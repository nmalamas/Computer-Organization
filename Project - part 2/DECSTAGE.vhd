----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:03:13 04/07/2024 
-- Design Name: 
-- Module Name:    DECODE - Behavioral 
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

entity DECSTAGE is
    Port ( 
			  --Inputs--
			  Instr : in  STD_LOGIC_VECTOR (31 downto 0);
			  immed_operation: in  STD_LOGIC_VECTOR (1 downto 0);
           RF_WrEn : in  STD_LOGIC;
           ALU_Out : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_Out : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrData_sel : in  STD_LOGIC;
           RF_B_sel : in  STD_LOGIC;
			  RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
			  
			  --Outputs--
           Immed : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_A : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : out  STD_LOGIC_VECTOR (31 downto 0)
           );
end DECSTAGE;

architecture Behavioral of DECSTAGE is

--SIGNALS--
signal readRegister2 : std_logic_vector(4 downto 0);
signal writeData_sig : std_logic_vector (31 downto 0);

signal instr_25_21 : std_logic_vector(4 downto 0);
signal instr_15_11 : std_logic_vector(4 downto 0);
signal instr_20_16 : std_logic_vector(4 downto 0);
signal instr_15_0 : std_logic_vector(15 downto 0);
signal instr_31_26 : std_logic_vector(5 downto 0);

--RegisterFile component
Component RegisterFile
    Port ( 
			  Ard1 : in  STD_LOGIC_VECTOR (4 downto 0);
           Ard2 : in  STD_LOGIC_VECTOR (4 downto 0);
           Awr  : in  STD_LOGIC_VECTOR (4 downto 0);
           Din  : in  STD_LOGIC_VECTOR (31 downto 0);
           WrEn : in  STD_LOGIC;
           CLK  : in  STD_LOGIC;
           RST  : in  STD_LOGIC;
			  Dout1 : out  STD_LOGIC_VECTOR (31 downto 0);
           Dout2 : out  STD_LOGIC_VECTOR (31 downto 0)
			  );
end Component;

--MUX_2to1 component
Component MUX_2to1
    Port ( 
			  SEL     : in  STD_LOGIC;
           IN0 		 : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
           IN1  		 : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
           MUX_OUT    : out  STD_LOGIC_VECTOR(31 DOWNTO 0)  
			  );
end Component;

--MUX_2to1_5bitInputs component
Component MUX_2to1_5bitInputs
    Port ( 
			  SEL     : in  STD_LOGIC;
           IN0 		 : in  STD_LOGIC_VECTOR(4 DOWNTO 0);
           IN1  		 : in  STD_LOGIC_VECTOR(4 DOWNTO 0);
           MUX_OUT    : out  STD_LOGIC_VECTOR(4 DOWNTO 0)  
			  );
end Component;


--Immediate_Conversion_Unit Component
component Immediate_Conversion_Unit
    Port ( 
			  immed_operation: in  STD_LOGIC_VECTOR (1 downto 0);
			  Instr_15_0  : in STD_LOGIC_VECTOR (15 downto 0);
			  Immed : out  STD_LOGIC_VECTOR (31 downto 0)
			  );
end component;

begin

	mux_2to1_read_reg2 : MUX_2to1_5bitInputs
	port map(
		SEL => RF_B_sel,
	   IN0 => instr_15_11,
	   IN1 => instr_20_16,
	   MUX_OUT => readRegister2 
	);

	WriteData_mux_2to1 : MUX_2to1
	port map(
		SEL => RF_WrData_sel,
	   IN0 => ALU_Out,
	   IN1 => MEM_Out,
	   MUX_OUT => writeData_sig 
	);
	
	rf : RegisterFile
	port map(
		  Ard1 => instr_25_21,
		  Ard2 => readRegister2,
		  Awr => instr_20_16,
		  Din  => writeData_sig,
		  WrEn => RF_WrEn,
		  CLK  => CLK,
		  RST  => RST,
		  Dout1 => RF_A,
		  Dout2 => RF_B
	);
	
	ICU : Immediate_Conversion_Unit
	port map(
		immed_operation =>  immed_operation,
		Instr_15_0 => instr_15_0,
		Immed => Immed
	);
	
instr_25_21 <= Instr(25) & Instr(24) & Instr(23) & Instr(22) & Instr(21);
instr_15_11 <= Instr(15) & Instr(14) & Instr(13) & Instr(12) & Instr(11);
instr_20_16 <= Instr(20) & Instr(19) & Instr(18) & Instr(17) & Instr(16);
instr_15_0 <= Instr(15) & Instr(14) & Instr(13) & Instr(12) & Instr(11) &
				  Instr(10) & Instr(9) & Instr(8) & Instr(7) & Instr(6) & Instr(5) & Instr(4)
					& Instr(3) & Instr(2) & Instr(1) & Instr(0);
instr_31_26 <= Instr(31) & Instr(30) & Instr(29) & Instr(28) & Instr(27) & Instr(26);


end Behavioral;

