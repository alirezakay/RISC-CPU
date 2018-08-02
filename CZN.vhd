----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:47:34 06/25/2017 
-- Design Name: 
-- Module Name:    CZN - Behavioral 
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

entity CZN is
	port(
			clk : in std_logic;
			cznWrite : in std_logic;
			CZNin : in std_logic_vector(2 downto 0);
			CZNout : out std_logic_vector(2 downto 0)
			);
end CZN;

architecture behave of CZN is

begin
	process (clk) begin
		if rising_edge(clk) then
			if cznWrite = '1' then
				CZNout <= CZNin;
			end if;
		end if;
	end process;
	
end behave;

