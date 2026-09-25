----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:08:48 06/15/2024 
-- Design Name: 
-- Module Name:    Forward_Unit - Behavioral 
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

entity Forward_Unit is
    Port ( 
			  --Inputs--
			  EX_MEM_rd : in  STD_LOGIC_VECTOR (4 downto 0);
           MEM_WB_rd : in  STD_LOGIC_VECTOR (4 downto 0);
           ID_EX_rs : in  STD_LOGIC_VECTOR (4 downto 0);
           ID_EX_rt : in  STD_LOGIC_VECTOR (4 downto 0);
			  RF_WrEn: in STD_LOGIC;
			  
			  --Outputs--
           ForwardA : out  STD_LOGIC_VECTOR (1 downto 0);
           ForwardB : out  STD_LOGIC_VECTOR (1 downto 0));
end Forward_Unit;

architecture Behavioral of Forward_Unit is

begin

process(EX_MEM_rd,MEM_WB_rd,ID_EX_rs,ID_EX_rt,RF_WrEn)
	begin
	
	ForwardA <= "00";
	ForwardB <= "00";
	
		-- EXEC hazard --
		if (RF_WrEn = '1' 
		and EX_MEM_rd /= "00000"
		and EX_MEM_rd = ID_EX_rs) then
			ForwardA <= "10";
		end if;
		
		if (RF_WrEn = '1' 
		and EX_MEM_rd /= "00000"
		and EX_MEM_rd = ID_EX_rt) then
			ForwardB <= "10";
		end if;
		
		-- MEM hazard --
		if (RF_WrEn = '1' 
		and MEM_WB_rd /= "00000"
		and MEM_WB_rd = ID_EX_rs) then
			ForwardA <= "01";
		end if;
		
		if (RF_WrEn = '1' 
		and MEM_WB_rd /= "00000"
		and MEM_WB_rd = ID_EX_rt) then
			ForwardB <= "01";
		end if;
	
	end process;
end Behavioral;

