----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:26:04 06/25/2017 
-- Design Name: 
-- Module Name:    mux_4bits - Behavioral 
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
Entity mux_2bits is
    Generic(W : integer);
    Port (D0, D1, D2, D3 : in std_logic_vector(W-1 downto 0);
          S      : in std_logic_vector(1 downto 0);
          Y      : out std_logic_vector(W-1 downto 0));
 End;

Architecture behave of mux_2bits is
    begin
    y <= D0 when S = "00" else 
			D1 when S = "01" else
			D2 when S = "10" else D3;
 end;

