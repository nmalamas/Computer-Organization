----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:50:20 06/17/2024 
-- Design Name: 
-- Module Name:    MUX_2to1_15bits - Behavioral 
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

entity MUX_2to1_9bits is
    Port ( sel : in  STD_LOGIC;
           IN0 : in  STD_LOGIC_VECTOR (8 downto 0);
           IN1 : in  STD_LOGIC_VECTOR (8 downto 0);
           MUX_OUT : out  STD_LOGIC_VECTOR (8 downto 0));
end MUX_2to1_9bits;

architecture Behavioral of MUX_2to1_9bits is

begin
PROCESS(sel,IN0,IN1)
	begin
	
		if SEL = '0' then
			MUX_OUT <= IN0;
		elsif SEL = '1' then
			MUX_OUT <= IN1;
		end if; 	
		
END PROCESS;
end Behavioral;

