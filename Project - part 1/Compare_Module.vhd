----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:46:06 04/06/2024 
-- Design Name: 
-- Module Name:    Compare_Module - Behavioral 
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

entity Compare_Module is
    Port ( 
			  --Inputs--
			  Ard : in STD_LOGIC_VECTOR (4 downto 0);
           Awr : in STD_LOGIC_VECTOR (4 downto 0);
			  WrEn: in STD_LOGIC;
           
			  --Outputs--
			  cmpr_Out : out  STD_LOGIC
			  );
end Compare_Module;

architecture Behavioral of Compare_Module is

begin
process(Ard,Awr,WrEn)
	begin
	-- The output of the Compare Module is used
	-- as a select signal at the most outer MUX 2-to-1.
	--
	-- ==If the two addresses are the same (meaning that
	-- we are about to write new data on the selected register)
	-- and write enable is 1, 
	-- the output of the Compare Module is 1, in order for the MUX
	-- to output the newly written data.
	--
	-- ==In the case that the two addresses are NOT the same,
	-- the module outputs the value 0, in order for the MUX
	-- to output the value written in the selected register.
	
	cmpr_Out <= '0';
	
	if (WrEn = '1') then
		if (Ard = Awr) then
			cmpr_Out <= '1';
		else
			cmpr_Out <= '0';
		end if;
	end if;
	
end process;
end Behavioral;

