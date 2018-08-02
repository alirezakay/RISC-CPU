----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:38:20 06/25/2017 
-- Design Name: 
-- Module Name:    PC - Behavioral 
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

-- use package
--USE work.procmem_definitions.ALL;

ENTITY pc IS
	generic(width: natural := 13);
	PORT (
				clk : IN STD_LOGIC;
				rst_n : IN STD_LOGIC;
				pc_in : IN STD_LOGIC_VECTOR(width-1 DOWNTO 0);
				PC_en : IN STD_LOGIC;
				pc_out : OUT STD_LOGIC_VECTOR(width-1 DOWNTO 0)
			);
END pc;


ARCHITECTURE behave OF pc IS
BEGIN
	proc_pc : PROCESS(clk, rst_n)
	
		VARIABLE pc_temp : STD_LOGIC_VECTOR(width-1 DOWNTO 0);
		BEGIN
		
			IF rst_n = '0' THEN
				pc_temp := (OTHERS => '0');
			ELSIF RISING_EDGE(clk) THEN
					IF PC_en = '1' THEN
						pc_temp := pc_in;
					END IF;
			END IF;
			pc_out <= pc_temp;
			
	END PROCESS;
	
END behave;

