----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:27:13 06/15/2024 
-- Design Name: 
-- Module Name:    MUX_3to1 - Behavioral 
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

entity MUX_3to1 is
    Port ( IN_A : in  STD_LOGIC_VECTOR (31 downto 0);
           IN_B : in  STD_LOGIC_VECTOR (31 downto 0);
           IN_C : in  STD_LOGIC_VECTOR (31 downto 0);
           sel : in  STD_LOGIC_VECTOR (1 downto 0);
           MUX_OUT : out  STD_LOGIC_VECTOR (31 downto 0));
end MUX_3to1;

architecture Behavioral of MUX_3to1 is

begin
process(IN_A,IN_B,IN_C,sel)
	begin
		if sel = "00" then
			MUX_OUT <= IN_A;
		elsif sel = "01" then
			MUX_OUT <= IN_B;
		else
			MUX_OUT <= IN_C;
		end if;
	end process;
end Behavioral;

