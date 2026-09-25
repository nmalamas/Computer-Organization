----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:13:05 04/07/2024 
-- Design Name: 
-- Module Name:    Immediate_Conversion_Unit - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.numeric_std.all;

entity Immediate_Conversion_Unit is
    Port ( 
			  --Inputs--
			  Instr_15_0  : in STD_LOGIC_VECTOR (15 downto 0);
			  immed_operation  : in STD_LOGIC_VECTOR (1 downto 0);
			  
			  --Outputs--
			  Immed : out  STD_LOGIC_VECTOR (31 downto 0)
			  );
end Immediate_Conversion_Unit;

architecture Behavioral of Immediate_Conversion_Unit is

--SIGNALS--

begin
	process(Instr_15_0,immed_operation)
	begin
	
	-- Zero Fill
	if immed_operation = "00" then
		Immed(31 downto 16) <= "0000000000000000";
		Immed(15 downto 0) <= Instr_15_0(15 downto 0);
	-- SignExt(Immed)
	elsif immed_operation = "01" then
		if Instr_15_0(15) = '0' then
			Immed(31 downto 16) <= "0000000000000000";
			Immed(15 downto 0) <= Instr_15_0(15 downto 0);
		else
			Immed(31 downto 16) <= "1111111111111111";
			Immed(15 downto 0) <= Instr_15_0(15 downto 0);
		end if;
	-- 2<<signExtend(Imm)
	elsif immed_operation = "10" then
		if Instr_15_0(15) = '0' then
			Immed <= "00000000000000" & Instr_15_0 & "00";			
		else
			Immed <= "11111111111111" & Instr_15_0 & "00";			
		end if; 
	--<< 16 (zero-fill)
	else
		Immed(31 downto 16) <= Instr_15_0(15 downto 0);
		Immed(15 downto 0) <= "0000000000000000";
	end if;		
	end process;
end Behavioral;
