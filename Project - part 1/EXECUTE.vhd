----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:17:46 04/07/2024 
-- Design Name: 
-- Module Name:    EXECUTE - Behavioral 
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

entity EXECUTE is
    Port ( 
			  RF_A : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : in  STD_LOGIC_VECTOR (31 downto 0);
           Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           ALU_Bin_sel : in  STD_LOGIC;
           ALU_func : in  STD_LOGIC_VECTOR (3 downto 0);
			  Zero : out STD_LOGIC;
			  Cout : out STD_LOGIC;
			  Ovf : out STD_LOGIC;
           ALU_out : out  STD_LOGIC_VECTOR (31 downto 0));
end EXECUTE;

architecture Behavioral of EXECUTE is

--SIGNALS
signal mux2to1_out : std_logic_vector(31 downto 0);

-- ALU Component
component ALU is
    Port ( 
			  A 		 : in  STD_LOGIC_VECTOR (31 downto 0);
           B 		 : in  STD_LOGIC_VECTOR (31 downto 0);
           Op 		 : in  STD_LOGIC_VECTOR (3 downto 0);
			  ALU_Out : out  STD_LOGIC_VECTOR (31 downto 0);
           Zero    : out  STD_LOGIC;
           Cout    : out  STD_LOGIC;
           Ovf     : out  STD_LOGIC);
end component;

-- mux2to1 Component
component MUX_2to1 is
    Port ( 
			  SEL     : in  STD_LOGIC;
           IN0 		 : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
           IN1  		 : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
           MUX_OUT    : out  STD_LOGIC_VECTOR(31 DOWNTO 0));
end component;

begin

	ALU_inst : ALU 
	port map(
		A => RF_A,
		B => mux2to1_out,
		Op => ALU_func,
		ALU_Out => ALU_Out,
		Zero => Zero,
		Ovf => Ovf,
		Cout => Cout
		);
					
	mux2to1 : MUX_2to1 
	port map(
		IN0 => RF_B,
		IN1 => Immed,
		SEL => ALU_Bin_sel,
		MUX_OUT => mux2to1_out
		);

end Behavioral;

