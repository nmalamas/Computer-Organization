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
			  --CLK : in std_logic;
			  Instr_31_26 : in STD_LOGIC_VECTOR (31 downto 26);
			  Instr_15_0  : in STD_LOGIC_VECTOR (15 downto 0);
			  
			  --Outputs--
			  Immed : out  STD_LOGIC_VECTOR (31 downto 0)
			  );
end Immediate_Conversion_Unit;

architecture Behavioral of Immediate_Conversion_Unit is

--SIGNALS--
signal temp_Immed : std_logic_vector(31 downto 0);

begin
	process(Instr_31_26,Instr_15_0,temp_Immed)
	begin

		if(Instr_31_26 = "100000") then
			Immed <= "0000000000000000" & Instr_15_0;
		else
			temp_Immed <= "0000000000000000" & Instr_15_0;
			case Instr_31_26 is
			
				--li
				--SignExt(Immed)
				when "111000" =>
					if Instr_15_0(15) = '0' then
						Immed(31 downto 16) <= "0000000000000000";
						Immed(15 downto 0) <= Instr_15_0(15 downto 0);
					else
						Immed(31 downto 16) <= "1111111111111111";
						Immed(15 downto 0) <= Instr_15_0(15 downto 0);
					end if;
					
				--lui
				--<< 16 (zero-fill) 
				when "111001" =>
					Immed(31 downto 16) <= Instr_15_0(15 downto 0);
					Immed(15 downto 0) <= "0000000000000000";
					
				--addi
				--SignExtend(Imm)
				when "110000" =>
					if Instr_15_0(15) = '0' then
						Immed(31 downto 16) <= "0000000000000000";
						Immed(15 downto 0) <= Instr_15_0(15 downto 0);
					else
						Immed(31 downto 16) <= "1111111111111111";
						Immed(15 downto 0) <= Instr_15_0(15 downto 0);
					end if; 
				
				--andi
				--zeroFill(Imm)
				when "110010" =>
					Immed(31 downto 16) <= "0000000000000000";
					Immed(15 downto 0) <= Instr_15_0(15 downto 0);
					
				--ori
				--zeroFill(Imm)
				when "110011" =>
					Immed(31 downto 16) <= "0000000000000000";
					Immed(15 downto 0) <= Instr_15_0(15 downto 0);
					
				--B
				--2<<signExtend(Imm)
				when "111111" =>
					if Instr_15_0(15) = '0' then
						Immed <= "00000000000000" & Instr_15_0 & "00";			
					else
						Immed <= "11111111111111" & Instr_15_0 & "00";			
					end if; 
				
				--beq
				--2<<signExtend(Imm)
				when "010000" =>
					if Instr_15_0(15) = '0' then
						Immed <= "00000000000000" & Instr_15_0 & "00";			
					else
						Immed <= "11111111111111" & Instr_15_0 & "00";			
					end if; 

				--bne
				--2<<signExtend(Imm)
				when "010001" =>
					if Instr_15_0(15) = '0' then
						Immed <= "00000000000000" & Instr_15_0 & "00";			
					else
						Immed <= "11111111111111" & Instr_15_0 & "00";			
					end if; 
					
				--Lb
				--signExtend(Imm)
				when "000011" =>
					if Instr_15_0(15) = '0' then
						Immed <= "0000000000000000" & Instr_15_0;
					else
						Immed <= "1111111111111111" & Instr_15_0;
					end if;
								
				--Lw
				--signExtend(Imm)
				when "001111" =>
					if Instr_15_0(15) = '0' then
						Immed(31 downto 16) <= "0000000000000000";
						Immed(15 downto 0) <= Instr_15_0(15 downto 0);
					else
						Immed(31 downto 16) <= "1111111111111111";
						Immed(15 downto 0) <= Instr_15_0(15 downto 0);
					end if;
					
				--Sw
				--signExtend(Imm)
				when "011111" =>
					if Instr_15_0(15) = '0' then
						Immed(31 downto 16) <= "0000000000000000";
						Immed(15 downto 0) <= Instr_15_0(15 downto 0);
					else
						Immed(31 downto 16) <= "1111111111111111";
						Immed(15 downto 0) <= Instr_15_0(15 downto 0);
					end if;
				
				when others =>
					null;
			end case;
		end if;
		
	end process;
end Behavioral;




