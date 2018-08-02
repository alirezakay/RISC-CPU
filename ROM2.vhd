----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:19:48 06/25/2017 
-- Design Name: 
-- Module Name:    ROM - Behavioral 
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

entity ROM2 is
	port(
		opcode: in std_logic_vector(2 downto 0);
		lineNumber: out std_logic_vector(3 downto 0)
		);
end ROM2;

architecture Behavioral of ROM2 is
	
begin

	with opcode select lineNumber <=
		"1000" when "110",
		"1001" when "000",
		"1011" when "010",
		"1100" when "011",
		"0000" when others;

end Behavioral;

