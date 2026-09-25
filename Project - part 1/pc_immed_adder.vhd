----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:36:31 04/05/2024 
-- Design Name: 
-- Module Name:    immed_adder - Behavioral 
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

entity immed_adder is
    Port ( 
			  --Inputs--
			  --RST : IN STD_LOGIC;
			  PC_Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           plus4incrementedPC : in  STD_LOGIC_VECTOR (31 downto 0);
			  
			  --Outputs--
           immed_adder_out : out  STD_LOGIC_VECTOR (31 downto 0));
end immed_adder;

architecture Behavioral of immed_adder is

signal tmp : STD_LOGIC_VECTOR(31 downto 0);

begin
	process(PC_Immed,plus4incrementedPC,tmp)--,RST)
		begin
			-- In case of a branch instruction the PC
			-- is incremented by 4 plus the immediate value
			-- used to reach the address of the instruction
			-- in ROM
--			if RST = '1' then
--				immed_adder_out <= "00000000000000000000000000000000";
--			else
--				--Add 4(0000 0000 0000 0000 0000 0000 0000 0100)
--				immed_adder_out <= plus4incrementedPC + PC_Immed;
--			end if;
			tmp <= plus4incrementedPC + PC_Immed;
			
	end process;
	immed_adder_out <= tmp;
end Behavioral;

