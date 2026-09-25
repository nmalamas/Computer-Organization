----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    05:49:08 04/06/2024 
-- Design Name: 
-- Module Name:    MUX_32to1 - Behavioral 
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

entity MUX_32to1 is
    Port ( 
			  --Inputs--
			  IN0  : in  STD_LOGIC_VECTOR (31 downto 0);
           IN1  : in  STD_LOGIC_VECTOR (31 downto 0);
           IN2  : in  STD_LOGIC_VECTOR (31 downto 0);
           IN3  : in  STD_LOGIC_VECTOR (31 downto 0);
           IN4  : in  STD_LOGIC_VECTOR (31 downto 0);
           IN5  : in  STD_LOGIC_VECTOR (31 downto 0);
           IN6  : in  STD_LOGIC_VECTOR (31 downto 0);
           IN7  : in  STD_LOGIC_VECTOR (31 downto 0);
           IN8  : in  STD_LOGIC_VECTOR (31 downto 0);
           IN9  : in  STD_LOGIC_VECTOR (31 downto 0);
           IN10 : in  STD_LOGIC_VECTOR (31 downto 0);
           IN11 : in  STD_LOGIC_VECTOR (31 downto 0);
           IN12 : in  STD_LOGIC_VECTOR (31 downto 0);
           IN13 : in  STD_LOGIC_VECTOR (31 downto 0);
           IN14 : in  STD_LOGIC_VECTOR (31 downto 0);
           IN15 : in  STD_LOGIC_VECTOR (31 downto 0);
           IN16 : in  STD_LOGIC_VECTOR (31 downto 0);
           IN17 : in  STD_LOGIC_VECTOR (31 downto 0);
           IN18 : in  STD_LOGIC_VECTOR (31 downto 0);
           IN19 : in  STD_LOGIC_VECTOR (31 downto 0);
           IN20 : in  STD_LOGIC_VECTOR (31 downto 0);
           IN21 : in  STD_LOGIC_VECTOR (31 downto 0);
           IN22 : in  STD_LOGIC_VECTOR (31 downto 0);
           IN23 : in  STD_LOGIC_VECTOR (31 downto 0);
           IN24 : in  STD_LOGIC_VECTOR (31 downto 0);
           IN25 : in  STD_LOGIC_VECTOR (31 downto 0);
           IN26 : in  STD_LOGIC_VECTOR (31 downto 0);
           IN27 : in  STD_LOGIC_VECTOR (31 downto 0);
           IN28 : in  STD_LOGIC_VECTOR (31 downto 0);
           IN29 : in  STD_LOGIC_VECTOR (31 downto 0);
           IN30 : in  STD_LOGIC_VECTOR (31 downto 0);
           IN31 : in  STD_LOGIC_VECTOR (31 downto 0);
           SEL  : in  STD_LOGIC_VECTOR (4 downto 0);
			  
			  --Outputs--
           MUX32to1_Out : out  STD_LOGIC_VECTOR (31 downto 0));
end MUX_32to1;

architecture Behavioral of MUX_32to1 is

begin
process(IN0,IN1,IN2,IN3,IN4,IN5,IN6,IN7,IN8,IN9,IN10,IN11,IN12,IN13,IN14,IN15,IN16,IN17,IN18,IN19,IN20,IN21,IN22,IN23,IN24,IN25,IN26,IN27,IN28,IN29,IN30,IN31,SEL)

begin
	
	case SEL is
		when "00000" =>
			 MUX32to1_Out <= IN0;
		when "00001" =>
			 MUX32to1_Out <= IN1;
		when "00010" =>
			 MUX32to1_Out <= IN2;
		when "00011" =>
			 MUX32to1_Out <= IN3;
		when "00100" =>
			 MUX32to1_Out <= IN4;
		when "00101" =>
			 MUX32to1_Out <= IN5;
		when "00110" =>
			 MUX32to1_Out <= IN6;
		when "00111" =>
			 MUX32to1_Out <= IN7;
		when "01000" =>
			 MUX32to1_Out <= IN8;
		when "01001" =>
			 MUX32to1_Out <= IN9;
		when "01010" =>
			 MUX32to1_Out <= IN10;
		when "01011" =>
			 MUX32to1_Out <= IN11;
		when "01100" =>
			 MUX32to1_Out <= IN12;
		when "01101" =>
			 MUX32to1_Out <= IN13;
		when "01110" =>
			 MUX32to1_Out <= IN14;
		when "01111" =>
			 MUX32to1_Out <= IN15;
		when "10000" =>
			 MUX32to1_Out <= IN16;
		when "10001" =>
			 MUX32to1_Out <= IN17;
		when "10010" =>
			 MUX32to1_Out <= IN18;
		when "10011" =>
			 MUX32to1_Out <= IN19;
		when "10100" =>
			 MUX32to1_Out <= IN20; 
		when "10101" =>
			 MUX32to1_Out <= IN21;
		when "10110" =>
			 MUX32to1_Out <= IN22;
		when "10111" =>
			 MUX32to1_Out <= IN23;
		when "11000" =>
			 MUX32to1_Out <= IN24;
		when "11001" =>
			 MUX32to1_Out <= IN25;
		when "11010" =>
			 MUX32to1_Out <= IN26;
		when "11011" =>
			 MUX32to1_Out <= IN27;
		when "11100" =>
			 MUX32to1_Out <= IN28;
		when "11101" =>
			 MUX32to1_Out <= IN29;
		when "11110" =>
			 MUX32to1_Out <= IN30;
		when "11111" =>
			 MUX32to1_Out <= IN31;
		when others =>
			 null;
	end case;
end process;
end Behavioral;

