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
			  current_pc : in  STD_LOGIC_VECTOR (31 downto 0);
			  
			  --Outputs--
           next_pc    : out  STD_LOGIC_VECTOR (31 downto 0));
end plus4incrementor;

architecture Behavioral of plus4incrementor is

signal tmp : STD_LOGIC_VECTOR (31 downto 0);

begin
PROCESS(current_pc)
BEGIN
	--In regular flow of program execution, the PC moves by 4
	--in order to get the next instruction
		tmp <= current_pc + "00000000000000000000000000000100";
END PROCESS;
next_pc <= tmp;
end Behavioral;
