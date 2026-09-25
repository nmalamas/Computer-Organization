----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:32:01 04/06/2024 
-- Design Name: 
-- Module Name:    IFSTAGE - Structural 
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

entity IFSTAGE is
    Port ( PC_Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_Sel   : in  STD_LOGIC;
           PC_LdEn  : in  STD_LOGIC;
           CLK      : in  STD_LOGIC;
           RST      : in  STD_LOGIC;
           Instr    : out  STD_LOGIC_VECTOR (31 downto 0));
end IFSTAGE;

architecture Behavioral of IFSTAGE is

-- SIGNALS --
SIGNAL ImAddOut  : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL nPC       : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL MUX_OUTPUT: STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL PC_out    : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL instr_out : STD_LOGIC_VECTOR(31 DOWNTO 0);

--MUX_2to1 Component
COMPONENT MUX_2to1
		PORT(
			 SEL  : in  STD_LOGIC;
          IN0 		: in  STD_LOGIC_VECTOR(31 DOWNTO 0);
          IN1  	: in  STD_LOGIC_VECTOR(31 DOWNTO 0);
			 MUX_OUT : out  STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
END COMPONENT;

--plus4incrementor Component
COMPONENT plus4incrementor
		PORT(
			 current_pc : in  STD_LOGIC_VECTOR (31 downto 0);
          next_pc    : out  STD_LOGIC_VECTOR (31 downto 0)
		);
END COMPONENT;

--immed_adder Component
COMPONENT immed_adder
		PORT(
			PC_Immed 			 : in  STD_LOGIC_VECTOR (31 downto 0);
         plus4incrementedPC : in  STD_LOGIC_VECTOR (31 downto 0);
			immed_adder_out    : out  STD_LOGIC_VECTOR (31 downto 0)
		);
END COMPONENT;

--rgstr/PC Component
COMPONENT rgstr
		PORT(
			 RST  : in  STD_LOGIC;
			 CLK  : in  STD_LOGIC;
          we   : in  STD_LOGIC;
          Data : in  STD_LOGIC_VECTOR (31 downto 0);
          Dout : out  STD_LOGIC_VECTOR (31 downto 0)
		);
END COMPONENT;

--ROM Component
COMPONENT IMEM_new
  PORT (
    a : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    spo : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END COMPONENT;

begin

	incrementor: plus4incrementor 
	PORT MAP(
		 current_pc => PC_out,
		 next_pc => nPC
		);
		
	adder: immed_adder
	PORT MAP(
		plus4incrementedPC => nPC,
		PC_Immed => PC_Immed,
		immed_adder_out => ImAddOut
		);
								
	PC: rgstr 
	PORT MAP(
		RST  => RST,
		CLK  => CLK,
		we   => PC_LdEn,
		Data => MUX_OUTPUT,
		Dout => PC_out
		);
								
	Instr_Mem: IMEM_new 
	PORT MAP(
		a => PC_out(11 downto 2),
		spo => Instr
		);
					
	mux2to1: MUX_2to1 
	PORT MAP(
		SEL  => PC_Sel,								
		IN0     => nPC,
		IN1     => ImAddOut,
		MUX_OUT => MUX_OUTPUT
		);
				
end Behavioral;