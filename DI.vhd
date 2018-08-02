----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:03:20 06/25/2017 
-- Design Name: 
-- Module Name:    DI - Behavioral 
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

entity DI is
	port( clk : in std_logic;
			rst_n : in std_logic;
			writeDI : in std_logic;
			Din : in std_logic_vector(4 downto 0);
			Dout : out std_logic_vector(4 downto 0)
		);
end DI;

architecture behave of DI is

begin
	process (clk, rst_n)
	begin
		if rst_n = '0' then
			Dout <= (others => '0');
		elsif rising_edge(clk) then
			if(writeDI = '1') then
				Dout <= Din;
			end if;
		end if;
	end process;

end behave;

