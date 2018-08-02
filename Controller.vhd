----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:19:14 06/25/2017 
-- Design Name: 
-- Module Name:    Controller - Behavioral 
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
--use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Controller is
	port( clk, reset: in std_logic;
			opcode: in std_logic_vector(3 downto 0);
			pcSrc, pcWrite, pcWriteCond, IorD, MemWrite, IRWrite1, IRWrite2,  MUXR1,
			RegDST, MemToReg, RegWrite, AluSrc2, DIWrite, CZNWrite : out std_logic;
			AluOp : out std_logic_vector(2 downto 0);
			controlmemData : out std_logic_vector(18 downto 0);
			nxtline :out std_logic_vector(3 downto 0);
			cardata : out std_logic_vector(3 downto 0)
		);
			
end Controller;

architecture behave of Controller is

	component ROM1 is
		port(
			opcode: in std_logic_vector(3 downto 0);
			lineNumber: out std_logic_vector(3 downto 0)
		);
	end component;
	
	component ROM2 is
		port(
			opcode: in std_logic_vector(2 downto 0);
			lineNumber: out std_logic_vector(3 downto 0)
		);
	end component;
	
	component ControlMemory is
		generic (K: integer:=19; -- number of bits per word (data size)
					W: integer:=4 -- number of address bits  (address size)
				); 
		port ( 	clk, rst_n : std_logic;
					ADDR: in std_logic_vector (W-1 downto 0); -- RAM address
					DOUT: out std_logic_vector (K-1 downto 0)
				); -- read data
	end component;
	
	component CAR is
		port( clk, rst_n : in std_logic;
			memIndex_input : in std_logic_vector(3 downto 0);
			memIndex_output : out std_logic_vector(3 downto 0)
			);
	end component;
	
	component mux_2bits is
			Generic(W : integer :=4);
			Port (D0, D1, D2, D3 : in std_logic_vector(W-1 downto 0);
          S      : in std_logic_vector(1 downto 0);
          Y      : out std_logic_vector(W-1 downto 0));
	end component;
	
	signal rom1ToMux : std_logic_vector(3 downto 0);
	signal rom2ToMux : std_logic_vector(3 downto 0);
	signal nextLine : std_logic_vector(3 downto 0);
	signal seq : std_logic_vector(1 downto 0) := "00";
	signal muxOut : std_logic_vector(3 downto 0);
	signal CARout : std_logic_vector(3 downto 0);
	signal controlWord : std_logic_vector(18 downto 0) := (others => '0');
	signal nextlinetemp : std_logic_vector(3 downto 0);
	signal zero4Signal : std_logic_vector(3 downto 0);
	
	
begin
	R1: ROM1 port map(opcode, rom1ToMux);
	R2: ROM2 port map(opcode(3 downto 1), rom2ToMux);
	
	zero4signal <= "0000";
	M: mux_2bits port map(zero4signal, rom1ToMux, rom2ToMux, nextLine, seq, muxOut);
	
	C: CAR port map(clk, reset, muxOut, CARout);
	cardata <= carout;
	
	Mem: ControlMemory port map(clk, reset, CARout, controlWord);
	
	seq <= controlWord(1 downto 0);
	nextlinetemp <= CARout + "0001";
	nextLine <= nextlinetemp;
	nxtline <= nextline;
	controlmemData <= controlword;
	
	process (clk, reset, controlword) begin
		if(reset = '0') then
			pcsrc <= '0';
			pcwrite <= '0';
			pcwritecond <= '0';
			iord <= '0';
			memwrite <= '0';
			irwrite1 <= '0';
			irwrite2 <= '0';
			muxr1 <= '0';
			regdst <= '0';
			memtoreg <= '0';
			regwrite <= '0';
			alusrc2 <= '0';
			aluop <= "000";
			diwrite <= '0';
			cznwrite <= '0';
		else
				pcsrc <= controlWord(18);
				pcwrite <= controlWord(17);
				pcwritecond <= controlWord(16);
				iord <= controlWord(15);
				memwrite <= controlWord(14);
				irwrite1 <= controlWord(13);
				irwrite2 <= controlWord(12);
				muxr1 <= controlWord(11);
				regdst <= controlWord(10);
				memtoreg <= controlWord(9);
				regwrite <= controlWord(8);
				alusrc2 <= controlWord(7);
				aluop <= controlWord(6 downto 4);
				diwrite <= controlWord(3);
				cznwrite <= controlWord(2);
		end if;
	end process;
	

end behave;

