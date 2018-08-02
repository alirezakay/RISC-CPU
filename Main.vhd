----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:18:28 06/25/2017 
-- Design Name: 
-- Module Name:    Main - Behavioral 
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

entity Main is
	port( clk : in std_logic;
			reset : in std_logic;
			op : out std_logic_vector(3 downto 0);
			memorydata : out std_logic_vector(7 downto 0);
			aluResult : out std_logic_vector(7 downto 0);
			controlWord : out std_logic_vector(18 downto 0);
			nextline :out std_logic_vector(3 downto 0);
			carout :out std_logic_vector(3 downto 0)

		);
end Main;

architecture Behavioral of Main is

	component Controller is
		port( clk, reset: in std_logic;
			opcode: in std_logic_vector(3 downto 0);
			pcSrc, pcWrite, pcWriteCond, IorD, MemWrite, IRWrite1, IRWrite2,  MUXR1,
			RegDST, MemToReg, RegWrite, AluSrc2, DIWrite, CZNWrite : out std_logic;
			AluOp : out std_logic_vector(2 downto 0);
			controlmemData : out std_logic_vector(18 downto 0);
			nxtline :out std_logic_vector(3 downto 0);
			cardata : out std_logic_vector(3 downto 0)

		);
	end component;
	
	component DataPath is
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
	end component;
	
	signal opcode : std_logic_vector(3 downto 0);
	signal  pcSrc, pcWrite, pcWriteCond, IorD, MemWrite, IRWrite1, IRWrite2,  MUXR1,
			RegDST, MemToReg, RegWrite, AluSrc2, DIWrite, CZNWrite : std_logic;
	signal aluop : std_logic_vector(2 downto 0);
begin

	DP : DataPath port map (clk, reset, pcSrc, pcWrite, pcWriteCond, IorD, MemWrite, IRWrite1, IRWrite2,  MUXR1,
			RegDST, MemToReg, RegWrite, AluSrc2, DIWrite, CZNWrite, AluOp, opcode, memorydata, aluresult);
			
	C: Controller port map(clk, reset, opcode, pcSrc, pcWrite, pcWriteCond, IorD, MemWrite, IRWrite1, IRWrite2,  MUXR1,
			RegDST, MemToReg, RegWrite, AluSrc2, DIWrite, CZNWrite, AluOp, controlword, nextline, carout);

	
	op <= opcode;

end Behavioral;

