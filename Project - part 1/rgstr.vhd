----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:59:25 04/05/2024 
-- Design Name: 
-- Module Name:    rgstr - Behavioral 
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

entity rgstr is
    Port ( 
			  --Inputs--
			  RST  : in  STD_LOGIC;
			  CLK  : in  STD_LOGIC;
           we   : in  STD_LOGIC;
           Data : in  STD_LOGIC_VECTOR (31 downto 0);
           
			  --Outputs--
			  Dout : out  STD_LOGIC_VECTOR (31 downto 0));
			  
end rgstr;

architecture Behavioral of rgstr is

signal new_data : std_logic_vector(31 downto 0);
signal curr_data : std_logic_vector(31 downto 0);

begin
	PROCESS(clk,rst,we,data,new_data,curr_data)
	BEGIN
		if rising_edge(clk) then
			new_data <= Data;
			-- When RST activated, put 0s in the Output of the register
			IF RST='1' THEN
				curr_data <= "00000000000000000000000000000000";
				Dout <= curr_data;
			ELSE
				-- When we=1, write the new data coming as input of the register
				IF we='1' THEN
					curr_data <= new_data;
					Dout <= new_data;
				ELSE
					Dout <= curr_data;
				END IF;
			END IF;
		end if;
	
	END PROCESS;
end Behavioral;

