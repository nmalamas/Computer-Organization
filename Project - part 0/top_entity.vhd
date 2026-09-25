----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:09:34 03/29/2024 
-- Design Name: 
-- Module Name:    top_entity - Structural 
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

entity top_entity is
	port(
		--Inputs
		CLK      : IN STD_LOGIC;
		RST      : IN STD_LOGIC;
		AddrWrite: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		AddrRead : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		w        : IN STD_LOGIC;
		r        : IN STD_LOGIC;
		NumberIN : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		
		--Outputs
		Valid    : OUT STD_LOGIC;
		NumberOUT: OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
end top_entity;

architecture Structural of top_entity is

SIGNAL controller_out : STD_LOGIC;

COMPONENT memory_controller
	PORT(
		--Inputs
		CLK    : IN STD_LOGIC;
		RST    : IN STD_LOGIC;
		w      : IN STD_LOGIC;
		r      : IN STD_LOGIC;
		
		--Outputs
		Valid  : OUT STD_LOGIC;
		we     : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT memory_module
	PORT(
		--Inputs
		a    : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		dpra : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		d    : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		clk  : IN STD_LOGIC;
		we   : IN STD_LOGIC;
		
		--Outputs
		spo  : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		dpo  : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END COMPONENT;

begin
	controller: memory_controller PORT MAP
										(CLK => CLK,
										 RST=> RST,
										 w => w,
										 r => r,
										 we => controller_out,
										 Valid => Valid
										);
	memory: memory_module PORT MAP
					(clk => CLK,
					 d => NumberIN,
					 a => AddrWrite,
					 dpra => AddrRead,
					 we => controller_out,
					 dpo => NumberOUT 
					);

end Structural;

