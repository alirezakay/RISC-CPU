----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:44:30 06/25/2017 
-- Design Name: 
-- Module Name:    MEM - Behavioral 
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
use IEEE.STD_LOGIC_1164.all;
use IEEE.Numeric_Std.all;

entity MEM is
	port (
		clock   : in  std_logic;
		rst_n	 : in  std_logic;
 		we      : in  std_logic;
		address : in  std_logic_vector(12 downto 0);
		datain  : in  std_logic_vector(7 downto 0);
		dataout : out std_logic_vector(7 downto 0)
	);
end entity MEM;

architecture behave of MEM is

   type ram_type is array (0 to (2**13)-1) of std_logic_vector(7 downto 0);
   signal ram : ram_type := (0 => "10000000", --(arithmetic opcode:4)(Acj:2)->(Aci:2); //overall 8bits 
									1 => "10000100",
									2 => "10010100",
									3 => "10110100",
									4 => "10000011",
									5 => "11111000",
									
									6 => "00100000", --instr. STA (store addressed)
									7 => "00001111",
									
									8 => "01000000", --instr. ADA (add addressed)
									9 => "00001111",
									
									10 => "11000000", --instr. JMP ( here : jump to mem(8) )
									11 => "00001100",
									
									12 => "00001000", --for jumping to this address (here : pc[12:8]&"00001000")
									
									others => "10000000"
								);
   signal read_address : std_logic_vector(12 downto 0);

begin

  RamProc: process(clock, rst_n) is

  begin
		if rising_edge(clock) then
			if we = '1' then
			ram(to_integer(unsigned(address))) <= datain;
			end if;
		end if;
  end process RamProc;
	read_address <= address;
	dataout <= ram(to_integer(unsigned(read_address)));
  
end architecture behave;







