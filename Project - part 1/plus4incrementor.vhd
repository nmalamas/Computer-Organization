----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:02:06 04/05/2024 
-- Design Name: 
-- Module Name:    plus4incrementor - Behavioral 
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
use IEEE.STD_LOGIC_SIGNED.ALL;

entity plus4incrementor is
    Port ( 
			  --Inputs--
			  RST : in STD_LOGIC;
			  CLK : in STD_LOGIC;
			  current_pc : in  STD_LOGIC_VECTOR (31 downto 0);
			  
			  --Outputs--
           next_pc    : out  STD_LOGIC_VECTOR (31 downto 0));
end plus4incrementor;

architecture Behavioral of plus4incrementor is

signal tmp : STD_LOGIC_VECTOR (31 downto 0);

begin
PROCESS(current_pc,CLK)
BEGIN
	--In regular flow of program execution, the PC moves 4 bytes
	--in order to get the next instruction
	IF RISING_EDGE(CLK) THEN
		tmp <= current_pc + "00000000000000000000000000000100";
	END IF;
END PROCESS;
next_pc <= tmp;
end Behavioral;
--
--begin
--PROCESS(current_pc,tmp,RST,CLK)
--BEGIN
--	--In regular flow of program execution, the PC moves 4 bytes
--	--in order to get the next instruction
--	IF RISING_EDGE(CLK) THEN
--		IF RST ='1' THEN
--			tmp <= "00000000000000000000000000000100";
--		ELSE IF RST='0' THEN
--			tmp <= current_pc + "00000000000000000000000000000100";
--		END IF;
--	END IF;
--END PROCESS;
--next_pc <= tmp;
--end Behavioral;

