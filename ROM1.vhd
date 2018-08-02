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

entity ROM1 is
	port(
		opcode: in std_logic_vector(3 downto 0);
		lineNumber: out std_logic_vector(3 downto 0)
		);
end ROM1;

architecture Behavioral of ROM1 is
	signal op_3_2 : std_logic_vector(1 downto 0);
begin
	
	op_3_2 <= opcode(3 downto 2);
	process (opcode, op_3_2) 
	begin
		case op_3_2 is
		when "10" =>
			case opcode(3 downto 0) is
				when "1000" => lineNumber <="0010";
				when "1001" => lineNumber <="0011";
				when "1010" => lineNumber <="0100";
				when "1011" => lineNumber <="0101";
				when others => lineNumber <="0000";
			end case;
		when others =>
			case opcode(3 downto 1) is
				when "111" => lineNumber <="0110";
				when "110" => lineNumber <="0111";
				when "000" => lineNumber <="0111";
				when "001" => lineNumber <="1010";
				when "010" => lineNumber <="0111";
				when "011" => lineNumber <="0111";
				when others => lineNumber <="0000";
			end case;
		end case;
	end process;
			

end Behavioral;

