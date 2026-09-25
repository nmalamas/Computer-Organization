----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    05:17:55 04/25/2024 
-- Design Name: 
-- Module Name:    CONTROL_UNIT - Behavioral 
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

entity CONTROL_UNIT is
    Port ( 
			  -- Inputs --
			  Instruction : in  STD_LOGIC_VECTOR (31 downto 0);
			  Zero : in STD_LOGIC;
			  RST : in STD_LOGIC;
			  
			  -- Outputs --
			  ctrl_out: out STD_LOGIC_VECTOR(14 downto 0)
			  
			  -- ===== Indices in the output vector ===== --
			  -- immed_operation  --> 1 downto 0
			  -- ALU_func 				   --> 5 downto 2
			  -- ALU_BIn_sel            --> 6
			  -- RF_WrData_sel 		--> 7
			  -- RF_WrEn 						--> 8
			  -- RF_B_sel                 --> 9
			  -- PC_LdEn 						--> 10
			  -- PC_Sel							--> 11
			  -- isLoadByte					--> 12
			  -- isConditionalBranch--> 13
			  -- MEM_WrEn 				 --> 14
			  -- ============================ --
	  );

end CONTROL_UNIT;

architecture Behavioral of CONTROL_UNIT is

--SIGNALS
signal opcode : std_logic_vector(5 downto 0);
signal func : std_logic_vector(5 downto 0);
signal PC_LdEn : std_logic;
signal PC_sel : std_logic;
signal zer_check : std_logic;

begin

process(Instruction,Zero,RST,func,opcode,PC_LdEn,PC_sel)
	begin
	
			func<= Instruction(5 downto 0);
			opcode<= Instruction(31 downto 26);
			PC_LdEn <= '1';
			PC_sel <= '0';
			zer_check <= Zero;
		
			if RST = '1' then
				  -- do nothing
						--							14		13	12	     11	  10	  9	   8		 7	  6	5432        10
					  ctrl_out <= "0"&"0"&"0"& PC_sel & "0" &"0"&"0"&"0"&"0"&"0000"&"00";
			else
				case opcode is
						-- nop
						when "000000" => 
						--							14		13	12	     11	         10	        9	   8		 7	  6		5432      10
						  ctrl_out <= "0"&"0"&"0"& PC_sel & PC_LdEn &"0"&"0"&"0"&"0"&"0000"&"00";
								  	
						-- R-type --
						when "100000" =>
						--							14		13	12	     11	         10	        9	   8		 7	  6		 5432       					  10
						  ctrl_out <= "0"&"0"&"0"& PC_sel & PC_LdEn &"0"&"1"&"0"&"0"& func(3 downto 0) &"00";--
						
						-- I-type --
						-- li
						when "111000" =>
						--							14		13	12	     11	         10	        9	   8		 7	  6		5432      10
						  ctrl_out <= "0"&"0"&"0"& PC_sel & PC_LdEn &"1"&"1"&"0"&"1"&"0000"& "01";
						  
						-- lw
						when "001111" =>
						--							14		13	12	     11	         10	        9	   8		 7	  6		5432      10
						  ctrl_out <= "0"&"0"&"0"& PC_sel & PC_LdEn &"0"&"1"&"1"&"1"&"0000"& "01";
						  
						-- sw
						when "011111" =>
						--							14		13	12	     11	         10	        9	   8		 7	  6		5432      10
						  ctrl_out <= "1"&"0"&"0"& PC_sel & PC_LdEn &"1"&"0"&"0"&"1"&"0000"& "01";
						  
						----------------------------------------------------------------------------------------------------------  
						  
						-- lui
						when "111001" => 
						--							14		13	12	     11	         10	        9	   8		 7	  6		5432      10
						  ctrl_out <= "0"&"0"&"0"& PC_sel & PC_LdEn &"0"&"1"&"0"&"1"&"0000"&"11";
						  
						-- addi
						when "110000" => 
						--							14		13	12	     11	         10	        9	   8		 7	  6		5432      10
						  ctrl_out <= "0"&"0"&"0"& PC_sel & PC_LdEn &"0"&"1"&"0"&"1"&"0000"&"01";
						  
						--andi
						when "110010" => 
						--							14		13	12	     11	         10	        9	   8		 7	  6		5432      10
						  ctrl_out <= "0"&"0"&"0"& PC_sel & PC_LdEn &"0"&"1"&"0"&"1"&"0000"&"00";
						  
						-- ori
						when "110011" => 
						--							14		13	12	     11	         10	        9	   8		 7	  6		5432      10
						  ctrl_out <= "0"&"0"&"0"& PC_sel & PC_LdEn &"0"&"1"&"0"&"1"&"0000"&"00";
						  
						-- B
						when "111111" => 
						--							14		13	12	     11	         10	     9	   8		 7	  6		5432      10
						  ctrl_out <= "0"&"0"&"0"&   "1" & PC_LdEn &"0"&"0"&"0"&"1"&"0000"&"10";
						 
						-- beq
						when "010000" => 
							if zer_check = '1' then
								PC_sel <= '1';
							else
								PC_sel <= '0';
							end if;
						--							14		13	12	     11	         10	        9	   8		 7	  6		5432      10
						  ctrl_out <= "0"&"1"&"0"& PC_sel & PC_LdEn &"1"&"0"&"0"&"0"&"0001"&"10";
						  
						-- bne
						when "010001" => 
							if zer_check = '1' then
								PC_sel <= '0';
							else
								PC_sel <= '1';
							end if;
						--							14		13	12	     11	         10	        9	   8		 7	  6		5432      10
						  ctrl_out <= "0"&"1"&"0"& PC_sel & PC_LdEn &"1"&"0"&"0"&"0"&"0001"&"10";
						  
						-- lb
						 when "000011" => 
						--							14		13	12	     11	         10	        9	   8		 7	  6		5432      10
						  ctrl_out <= "0"&"0"&"1"& PC_sel & PC_LdEn &"1"&"1"&"1"&"1"&"0000"&"00";
							
						when others => 
							null;
					end case;
		end if;
	end process;
end Behavioral;