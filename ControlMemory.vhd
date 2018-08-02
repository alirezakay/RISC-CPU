----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:53:57 06/25/2017 
-- Design Name: 
-- Module Name:    ControlMemory - Behavioral 
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
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity ControlMemory is
	generic (K: integer:=19; -- number of bits per word (data size)
				W: integer:=4 -- number of address bits  (address size)
			 ); 
	port (
		clk, rst_n : std_logic;
		ADDR: in std_logic_vector (W-1 downto 0); -- RAM address
		DOUT: out std_logic_vector (K-1 downto 0)); -- read data
end ControlMemory;


architecture behave of ControlMemory is

	subtype WORD is std_logic_vector ( K-1 downto 0); -- define size of WORD
	type MEMORY is array (0 to 2**W-1) of WORD; -- define size of MEMORY
	signal RAM16: MEMORY; -- define RAM16 as signal of type MEMORY
	
	begin
	process (clk, rst_n, ADDR, RAM16)
	
		variable RAM_ADDR_IN: integer range 0 to 2**W-1; -- to translate address to integer
		--variable STARTUP: boolean :=true; -- temporary variable for initialization
		
		begin
			if (rst_n = '0') then -- for initialization of RAM during start of simulation
				RAM16 <= (0 =>   "0100010000000000011", -- initializes first 12 locations in Control Memory
									1 => "0000001000000000001", -- to specific values
									2 => "0000000110100000000", 
									3 => "0000000110100100100", 
									4 => "0000000110101000100",
									5 => "0000000110101010100",
									6 => "0000000000000001000",
									7 => "0001000000000000010",
									8 => "1010000000000000000",
									9 => "0100000001100000000",
									10 => "0101100000000000000",
									11 => "0100000000110010100",
									12 => "0100000000111000100",
									others => "0000000000000000000"
								);
				DOUT <= "XXXXXXXXXXXXXXXXXXX"; -- force undefined logic values on RAM output
			else
				--if rising_edge(clk) then
					RAM_ADDR_IN := conv_integer (ADDR); -- converts address to integer
				--end if;
				DOUT <= RAM16 (RAM_ADDR_IN);
			end if;
end process;

end architecture behave;

