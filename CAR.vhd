----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:52:36 06/25/2017 
-- Design Name: 
-- Module Name:    CAR - Behavioral 
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

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CAR is
	port( clk, rst_n : in std_logic;
			memIndex_input : in std_logic_vector(3 downto 0);
			memIndex_output : out std_logic_vector(3 downto 0)
			);
end CAR;

architecture Behavioral of CAR is
	signal temp : std_logic_vector(3 downto 0):="0000";
begin
	process(clk, rst_n) begin
	if rst_n = '0' then
		temp <= "1111";
	else
		if rising_edge(clk) then
			temp <= memIndex_input;
		end if;
	end if;
	end process;
	memindex_output <= temp;


end Behavioral;

