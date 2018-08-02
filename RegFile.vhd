----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:41:15 06/25/2017 
-- Design Name: 
-- Module Name:    RegFile - Behavioral 
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


ENTITY regfile IS
	GENERIC (	width : natural := 8;  --data width
					regfile_depth : positive := 4;  --number of accumulator registers
					regfile_adrsize : positive := 2 --address size for addressing acc. registers
				);
	PORT (clk,rst_n : IN std_logic;
				RegWrite : IN std_logic; -- write control
				writeport : IN std_logic_vector(width-1 DOWNTO 0); -- register input
				adrwport : IN std_logic_vector(regfile_adrsize-1 DOWNTO 0);-- address write
				adrport0 : IN std_logic_vector(regfile_adrsize-1 DOWNTO 0);-- address port 0
				adrport1 : IN std_logic_vector(regfile_adrsize-1 DOWNTO 0);-- address port 1
				readport0 : OUT std_logic_vector(width-1 DOWNTO 0); -- output port 0
				readport1 : OUT std_logic_vector(width-1 DOWNTO 0) -- output port 1
				--r0 : OUT std_logic_vector(width-1 DOWNTO 0);
				--r1 : OUT std_logic_vector(width-1 DOWNTO 0);
				--r2 : OUT std_logic_vector(width-1 DOWNTO 0);
				--r3 : OUT std_logic_vector(width-1 DOWNTO 0)
			);
			
END regfile;


ARCHITECTURE behave OF regfile IS

	SUBTYPE WordT IS std_logic_vector(width-1 DOWNTO 0); -- reg word TYPE
	TYPE StorageT IS ARRAY(0 TO regfile_depth-1) OF WordT; -- reg array TYPE
	SIGNAL registerfile : StorageT; -- reg file contents
	
BEGIN
	-- perform write operation
	PROCESS(rst_n, clk)
	BEGIN
		IF rst_n = '0' THEN
			FOR i IN 0 TO regfile_depth-1 LOOP
				registerfile(i) <= (OTHERS => '0');
			END LOOP;
			registerfile(1) <= "00000001";
			
		ELSIF rising_edge(clk) THEN
			IF RegWrite = '1' THEN
				registerfile(to_integer(unsigned(adrwport))) <= writeport;
			END IF;
		END IF;
	END PROCESS;
	-- perform reading ports
	readport0 <= registerfile(to_integer(unsigned(adrport0)));
	readport1 <= registerfile(to_integer(unsigned(adrport1)));
	
	--r0 <= registerfile(0);
	--r1 <= registerfile(1);
	--r2 <= registerfile(2);
	--r3 <= registerfile(3);
	
END behave;

