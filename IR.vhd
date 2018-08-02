----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:54:54 06/25/2017 
-- Design Name: 
-- Module Name:    IR - Behavioral 
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

ENTITY IR IS
	generic (width : natural :=8);
	PORT (
				clk : IN STD_LOGIC;   -- clock signal
				rst_n : IN STD_LOGIC;  -- reset signal
				memdata : IN STD_LOGIC_VECTOR(width-1 DOWNTO 0);  -- memoryData stored into the IR
				IRWrite : IN STD_LOGIC;
				instr : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
			);
END IR;

ARCHITECTURE behave OF IR IS
BEGIN

	proc_instreg : PROCESS(clk, rst_n)
	BEGIN
		IF rst_n = '0' THEN
			instr <= (OTHERS => '0');
		ELSIF RISING_EDGE(clk) THEN
			-- write the output of the memory into the instruction register
			IF(IRWrite = '1') THEN
				instr <= memdata;
			END IF;
		END IF;
	END PROCESS;
	
END behave;

