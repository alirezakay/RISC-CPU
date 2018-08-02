----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:58:39 06/25/2017 
-- Design Name: 
-- Module Name:    MDR - Behavioral 
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
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;


ENTITY MDR IS
	generic (width : natural :=8);
	PORT (
				clk : IN STD_LOGIC;   -- clock signal
				rst_n : IN STD_LOGIC;  -- reset signal
				memdata : IN STD_LOGIC_VECTOR(width-1 DOWNTO 0);  -- memoryData stored into the IR
				dataOut : OUT STD_LOGIC_VECTOR(width-1 DOWNTO 0)
			);
END MDR;

ARCHITECTURE behave OF MDR IS
BEGIN

	proc_instreg : PROCESS(clk, rst_n)
	BEGIN
		IF rst_n = '0' THEN
			dataOut <= (OTHERS => '0');
		ELSIF RISING_EDGE(clk) THEN
			dataOut <= memdata;
		END IF;
	END PROCESS;
	
END behave;

