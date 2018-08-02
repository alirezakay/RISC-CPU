----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:30:37 06/25/2017 
-- Design Name: 
-- Module Name:    DataPath - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DataPath is
	port(
			clk : in std_logic;
			reset : in std_logic;
			pcSrc, pcWrite, pcWriteCond, IorD, MemWrite, IRWrite1, IRWrite2,  MUXR1,
			RegDST, MemToReg, RegWrite, AluSrc2, DIWrite, CZNWrite : in std_logic;
			AluOp : in std_logic_vector(2 downto 0);
			opcode : out std_logic_vector(3 downto 0);
			memorydata : out std_logic_vector(7 downto 0);
			aluResult : out std_logic_vector(7 downto 0)
	);
end DataPath;

architecture rtl of DataPath is

	component pc is
		generic(width: natural := 13);
		PORT (
				clk : IN STD_LOGIC;
				rst_n : IN STD_LOGIC;
				pc_in : IN STD_LOGIC_VECTOR(width-1 DOWNTO 0);
				PC_en : IN STD_LOGIC;
				pc_out : OUT STD_LOGIC_VECTOR(width-1 DOWNTO 0)
			);
	END component;
	
	component MEM is
		port (
			clock   : in  std_logic;
			rst_n : in std_logic;
			we      : in  std_logic;
			address : in  std_logic_vector(12 downto 0);
			datain  : in  std_logic_vector(7 downto 0);
			dataout : out std_logic_vector(7 downto 0)
			);
	end component;
	
	component adder is
		Port (A, B : in std_logic_vector(12 downto 0);
					Y    : out std_logic_vector(12 downto 0)
				);
    End component;
	 
	 component IR IS
		generic (width : natural :=8);
		PORT (
				clk : IN STD_LOGIC;   -- clock signal
				rst_n : IN STD_LOGIC;  -- reset signal
				memdata : IN STD_LOGIC_VECTOR(width-1 DOWNTO 0);  -- memoryData stored into the IR
				IRWrite : IN STD_LOGIC;
				instr : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
			);
	END component;
	
	component MDR IS
		generic (width : natural :=8);
		PORT (
				clk : IN STD_LOGIC;   -- clock signal
				rst_n : IN STD_LOGIC;  -- reset signal
				memdata : IN STD_LOGIC_VECTOR(width-1 DOWNTO 0);  -- memoryData stored into the IR
				dataOut : OUT STD_LOGIC_VECTOR(width-1 DOWNTO 0)
			);
	END component;
	
	component DI is
		port( clk : in std_logic;
			rst_n : in std_logic;
			writeDI : in std_logic;
			Din : in std_logic_vector(4 downto 0);
			Dout : out std_logic_vector(4 downto 0)
		);
	end component;
	
	component alu is
		Generic(W : natural := 8; Cw : natural := 3);
		port(SrcA       : in std_logic_vector(W-1 downto 0);
         SrcB       : in std_logic_vector(W-1 downto 0);
			Cin		  : in std_logic;
         AluControl : in std_logic_vector(Cw-1 downto 0);
         AluResult  : out std_logic_vector(W-1 downto 0);
         Zero       : out std_logic;
         Overflow   : out std_logic;
         CarryOut   : out std_logic;
			Neg : out std_logic --negative signal
			);
	End component;
	
	component CZN is
		port(
			clk : in std_logic;
			cznWrite : in std_logic;
			CZNin : in std_logic_vector(2 downto 0);
			CZNout : out std_logic_vector(2 downto 0)
			);
	end component ;
	
	component mux is
    Generic(W : integer );
    Port (D0, D1 : in std_logic_vector(W-1 downto 0);
          S      : in std_logic;
          Y      : out std_logic_vector(W-1 downto 0));
	End component ;
	
	component regfile IS
		GENERIC (	width : natural := 8;  --data width
					regfile_depth : positive := 4;  --number of accumulator registers
					regfile_adrsize : positive := 2 --address size for addressing acc. registers
				);
		PORT (clk,rst_n : IN std_logic;
				RegWrite : IN std_logic; -- write control
				writeport : IN std_logic_vector(width-1 DOWNTO 0); -- register input
				adrwport : IN std_logic_vector(regfile_adrsize-1 DOWNTO 0);-- address write
				adrport0 : IN std_logic_vector(regfile_adrsize-1 DOWNTO 0);-- address port 0
				adrport1 : IN std_logic_vector(regfile_adrsize-1 DOWNTO 0);-- address port 1
				readport0 : OUT std_logic_vector(width-1 DOWNTO 0); -- output port 0
				readport1 : OUT std_logic_vector(width-1 DOWNTO 0) -- output port 1
			);
			
	END component;
	
	component mux_2bits is
			Generic(W : integer :=1);
			Port (D0, D1, D2, D3 : in std_logic_vector(W-1 downto 0);
          S      : in std_logic_vector(1 downto 0);
          Y      : out std_logic_vector(W-1 downto 0));
	end component;
	
	
	signal pcin : std_logic_vector(12 downto 0) := "0000000000000";
	--signal reset : std_logic := '0';
	signal pcen : std_logic; --pc enable signal
	signal pcout : std_logic_vector(12 downto 0);
	signal mux1out : std_logic_vector(12 downto 0);
	signal memdata : std_logic_vector(7 downto 0);
	--signal IRreset : std_logic :='0';
	signal instr1 : std_logic_vector(7 downto 0) ;
	signal instr2 : std_logic_vector(7 downto 0);
	signal mux1D1 : std_logic_vector(12 downto 0);
	signal mdrdata : std_logic_vector(7 downto 0) ;
	signal Acci : std_logic_vector(7 downto 0);
	signal Accj : std_logic_vector(7 downto 0);
	signal regfileWD : std_logic_vector(7 downto 0);
	signal regfileWR : std_logic_vector(1 downto 0);
	signal regfileR1 : std_logic_vector(1 downto 0) ;
	signal regfileR2 : std_logic_vector(1 downto 0);
	--signal regfilereset : std_logic := '0';
	signal DIout : std_logic_vector(4 downto 0); -- output of DI register
	signal nextLinePc : std_logic_vector(12 downto 0);
	signal jumpPc : std_logic_vector(12 downto 0);
	signal AluIn2 : std_logic_vector(7 downto 0) ; -- alu in B 
	signal CZNin : std_logic_vector(2 downto 0) ; 
	signal CZNout : std_logic_vector(2 downto 0) ; 
	signal C : std_logic := '0';
	signal Z : std_logic := '0';
	signal N : std_logic := '0';
	signal overflow : std_logic := '0';
	--signal DIreset: std_logic := '0';
	signal aluout : std_logic_vector(7 downto 0); 
	signal m0out : std_logic;

	
	
begin
	--M0: mux_2bits port map(logicone, c, z, n, diout(2 downto 1), m0out);
	m0out <= ((not diout(2)) and (not diout(1))) or ((not diout(2)) and diout(1) and c)
					or (diout(2) and (not diout(1)) and z) or (diout(2) and diout(1) and n);
	
	pcen <= ((m0out and pcwritecond)or(pcwrite));
	myPC : PC port map(clk, reset, pcin, pcen, pcout);
	
	mux1d1 <= (instr1(4 downto 0) & instr2);
	M1 : mux generic map(13) port map(pcout, mux1D1, IorD, mux1out);
	
	IR1 : IR port map(clk, reset, memdata, irwrite1, instr1);
	opcode <= instr1(7 downto 4);
	IR2 : IR port map(clk, reset, memdata, irwrite2, instr2);
	myMDR : MDR port map(clk, reset, memdata, mdrdata);
	
	RAM : MEM port map(clk, reset, memwrite, mux1out, acci, memdata);
	memorydata <= memdata;
	
	regfiler2 <= instr1(3 downto 2);
	myREGFILE : regFile port map(clk, reset, regwrite, regfileWD, regfileWR, regfileR1, regfileR2, acci, accj);
	
	M2 : mux generic map(2) port map(diout(4 downto 3), instr1(1 downto 0), muxR1, regfiler1); 
	M3 : mux generic map(2) port map(diout(4 downto 3), instr1(1 downto 0), regdst, regfilewr);
	M4 : mux generic map(8) port map(aluout, mdrdata, memtoreg, regfilewd);
	
	PCAdd : adder port map (pcout, "0000000000001", nextlinepc);
	jumppc <= pcout(12 downto 8)&mdrdata;
	M5 : mux generic map(13) port map(nextlinepc, jumppc, pcsrc, pcin);
	
	M6 : mux generic map(8) port map(accj, mdrdata, alusrc2, aluin2);
	
	myALU : alu port map(acci, aluin2, cznout(2), aluop, aluout, Z, overflow, C, N);
	aluresult <= aluout;
	
	myDI : DI port map (clk, reset, diwrite, instr1(4 downto 0), diout);
	
	CZNin <= C&Z&N;
	myCZN : CZN port map(clk, cznwrite, cznin, cznout);  
	
end rtl;

