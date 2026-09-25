----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:04:52 04/05/2024 
-- Design Name: 
-- Module Name:    MUX_2to1 - Behavioral 
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

entity MUX_2to1 is
    Port ( 
			  --Inputs--
			  SEL     : in  STD_LOGIC;
           IN0 		 : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
           IN1  		 : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
			  
			  --Outputs--
           MUX_OUT    : out  STD_LOGIC_VECTOR(31 DOWNTO 0));
end MUX_2to1;

architecture Behavioral of MUX_2to1 is
begin
PROCESS(SEL,IN0,IN1)
	begin
	
		if SEL = '0' then
			MUX_OUT <= IN0;
		elsif SEL = '1' then
			MUX_OUT <= IN1;
		end if; 	
		
END PROCESS;
end Behavioral;

