----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:47:27 04/05/2024 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_SIGNED.ALL;

entity ALU is
    Port ( 
			  --Inputs--
			  A 		 : in  STD_LOGIC_VECTOR (31 downto 0);
           B 		 : in  STD_LOGIC_VECTOR (31 downto 0);
           Op 		 : in  STD_LOGIC_VECTOR (3 downto 0);
           
			  --Outputs--
			  ALU_Out : out  STD_LOGIC_VECTOR (31 downto 0);
           Zero    : out  STD_LOGIC;
           Cout    : out  STD_LOGIC;
           Ovf     : out  STD_LOGIC);
end ALU;

architecture Behavioral of ALU is

SIGNAL tmp_ALU_Out: STD_LOGIC_VECTOR (31 downto 0);
SIGNAL tmp_result: STD_LOGIC_VECTOR (32 downto 0);
SIGNAL twosComplB: STD_LOGIC_VECTOR (31 downto 0);

begin
process(A,B,Op,tmp_ALU_Out,tmp_result,twosComplB)

	begin
		case Op is
			-- ADD --
			when "0000" =>
				tmp_ALU_Out <= A + B;
				tmp_result <= ('0'&A) + ('0'&B);
				
				if tmp_result(32) = tmp_ALU_Out(31) then
					Cout <= tmp_result(32);
					Ovf <= '0';
				else
					Cout <= '0';
					Ovf <= '1';
				end if;
				
				if tmp_ALU_Out = "00000000000000000000000000000000" then
					Zero <= '1';
				else 
					Zero <= '0';
				end if;
				
				ALU_Out <= tmp_ALU_Out;
			
			-- SUB --
			when "0001" =>
				twosComplB <= NOT(B) + 1;
				
				tmp_ALU_Out <= A + twosComplB;
				tmp_result <= ('0'&A) + ('0'&B);
				
				if tmp_result(32) = tmp_ALU_Out(31) then
					Cout <= tmp_result(32);
					Ovf <= '0';
				else
					Cout <= '0';
					Ovf <= '1';
				end if;
				
				if tmp_ALU_Out = "00000000000000000000000000000000" then
					Zero <= '1';
				else 
					Zero <= '0';
				end if;
				
				ALU_Out <= tmp_ALU_Out;
			
			-- AND --
			when "0010" =>
				tmp_ALU_Out <=  A AND B;
				ALU_Out <= tmp_ALU_Out;
				Cout <= '0';
				Ovf <= '0';
				
				if tmp_ALU_Out = "00000000000000000000000000000000" then
					Zero <= '1';
				else 
					Zero <= '0';
				end if;
			
			-- OR --
			when "0011" =>
				tmp_ALU_Out <=  A OR B;
				ALU_Out <= tmp_ALU_Out;
				Cout <= '0';
				Ovf <= '0';
				
				if tmp_ALU_Out = "00000000000000000000000000000000" then
					Zero <= '1';
				else 
					Zero <= '0';
				end if;
			
			-- NOT --
			when "0100" =>
				for i in 0 to 31 loop
					tmp_ALU_Out(i) <= NOT A(i);
				end loop;
				
				ALU_Out <= tmp_ALU_Out;
				Cout <= '0';
				Ovf <= '0';
				
				if tmp_ALU_Out = "00000000000000000000000000000000" then
					Zero <= '1';
				else 
					Zero <= '0';
				end if;

			---------| SHIFT RIGHT ARITHMETIC |---------
			when "1000" =>
				-- Going up to 30, so that the 31st bit(no 30) gets the value of the 32nd bit
				-- and the 32nd bit(no 31) stays unchanged
				for i in 0 to 30 loop
					tmp_ALU_Out(i) <= A(i+1);
				end loop;
				
				tmp_ALU_Out(31) <= A(31);
				
				ALU_Out <= tmp_ALU_Out;
				Cout <= '0';
				Ovf <= '0';
				
				if tmp_ALU_Out = "00000000000000000000000000000000" then
					Zero <= '1';
				else 
					Zero <= '0';
				end if;
			
			---------| SHIFT RIGHT LOGICAL |---------
			when "1001" =>
				-- Going up to 30, so that the every bit gets the value of the next bit
				-- and after the loop
				-- the 32nd bit(no 31) gets the value 0.
				for i in 0 to 30 loop
					tmp_ALU_Out(i) <= A(i+1);
				end loop;
				
					tmp_ALU_Out(31) <= '0';
					
					ALU_Out <= tmp_ALU_Out;
					Cout <= '0';
					Ovf <= '0';
					
					if tmp_ALU_Out = "00000000000000000000000000000000" then
						Zero <= '1';
					else 
						Zero <= '0';
					end if;
			
			---------| SHIFT LEFT LOGICAL |---------
			when "1010" =>
				-- Going up to 31, so that the every bit gets the value of the previous bit
				-- and after the loop
				-- the 1st bit(no 0) gets the value 0.
				for i in 0 to 30 loop
					tmp_ALU_Out(i+1) <= A(i);
				end loop;
				
					tmp_ALU_Out(0) <= '0';
					
					ALU_Out <= tmp_ALU_Out;
					Cout <= '0';
					Ovf <= '0';
					
					if tmp_ALU_Out = "00000000000000000000000000000000" then
						Zero <= '1';
					else 
						Zero <= '0';
					end if;
				
			---------| ROTATE LEFT |---------	
			when "1100" =>
				-- Going up to 31, so that the every bit gets the value of the previous bit
				-- and after the loop
				-- the 1st bit(no 0) gets the value of the 32nd bit(no 31).
				for i in 0 to 30 loop
					tmp_ALU_Out(i+1) <= A(i);
				end loop;
				
					tmp_ALU_Out(0) <= A(31);
					
					ALU_Out <= tmp_ALU_Out;
					Cout <= '0';
					Ovf <= '0';
				
				if tmp_ALU_Out = "00000000000000000000000000000000" then
					Zero <= '1';
				else 
					Zero <= '0';
				end if;
				
			---------| ROTATE RIGHT |---------	
			when "1101" =>
				-- Going up to 31, so that the every bit gets the value of the next bit
				-- and after the loop
				-- the 32nd bit(no 31) gets the value of the 1st bit(no 0).
				for i in 0 to 30 loop
					tmp_ALU_Out(i) <= A(i+1);
				end loop;
				
				tmp_ALU_Out(31) <= A(0);
				
				ALU_Out <= tmp_ALU_Out;
				Cout <= '0';
				Ovf <= '0';
				
				if tmp_ALU_Out = "00000000000000000000000000000000" then
					Zero <= '1';
				else 
					Zero <= '0';
				end if;
				
			when others =>
				null;
		end case;
			
end process;
end Behavioral;

