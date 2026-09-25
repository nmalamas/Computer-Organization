----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    05:07:38 04/06/2024 
-- Design Name: 
-- Module Name:    RegisterFile - Behavioral 
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

entity RegisterFile is
    Port ( 
			  --Inputs--
			  Ard1 : in  STD_LOGIC_VECTOR (4 downto 0);
           Ard2 : in  STD_LOGIC_VECTOR (4 downto 0);
           Awr  : in  STD_LOGIC_VECTOR (4 downto 0);
           Din  : in  STD_LOGIC_VECTOR (31 downto 0);
           WrEn : in  STD_LOGIC;
           CLK  : in  STD_LOGIC;
           RST  : in  STD_LOGIC;
			  
			  --Outputs--
			  Dout1 : out  STD_LOGIC_VECTOR (31 downto 0);
           Dout2 : out  STD_LOGIC_VECTOR (31 downto 0)
			  );
end RegisterFile;

architecture Behavioral of RegisterFile is
  -----------------------------
--| INTERMEDIATE SINGALS USED |--
  -----------------------------

--Used for the connection of the decoder's outputs to the inputs
--of the 32 AND gates
signal decoder_5to32_out : std_logic_vector(31 downto 0);

--Used for the AND of WrEn with every output of the 5-to-32 decoder 
signal WrEn_AND_decoder_5to32_out : std_logic_vector(31 downto 0);

--Used for the connection of the Registers's outputs to the inputs
--of the two 32-to-1 MUXs
type Array_32by32 is array (natural range <>,natural range <>) of std_logic_vector(31 downto 0);
signal register_outputs : Array_32by32(0 to 31,0 to 31);  

--Used for the connection of the two 32-to-1 MUXs to the IN0 inputs
--of the two 2-to-1 MUXs
signal in0_upper_mux2to1 : std_logic_vector(31 downto 0);
signal in0_lower_mux2to1 : std_logic_vector(31 downto 0);

--Used for the connection of the CompareModules to the SEL
--of the two 2-to-1 MUXs
signal sel_upper_mux2to1 : std_logic;
signal sel_lower_mux2to1 : std_logic;

  --------------------------------------
--| The components of the blocks shown	 |--
  --------------------------------------

-- DECODER_5to32 Component
component DECODER_5to32
	Port ( 
			Awr  : in  STD_LOGIC_VECTOR (4 downto 0);
         WrEn : in  STD_LOGIC;
			Decoder5to32_Out : out STD_LOGIC_VECTOR (31 downto 0)
			);
end component;

-- rgstr Component
component rgstr
    Port ( 
			 RST  : in  STD_LOGIC;
			 CLK  : in  STD_LOGIC;
          we   : in  STD_LOGIC;
          Data : in  STD_LOGIC_VECTOR (31 downto 0);
			 Dout : out  STD_LOGIC_VECTOR (31 downto 0)
			 );	  
end component;

-- MUX_32to1 Component
component MUX_32to1
	Port(
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
		  MUX32to1_Out : out  STD_LOGIC_VECTOR (31 downto 0)
		);
end component;

-- Compare_Module Component
component Compare_Module
	Port(
			Ard : in  STD_LOGIC_VECTOR (4 downto 0);
         Awr : in  STD_LOGIC_VECTOR (4 downto 0);
			WrEn: in  STD_LOGIC;
			cmpr_Out : out  STD_LOGIC
			);
end component;

-- MUX_2to1 Component
component MUX_2to1
    Port ( 
			  SEL     : in  STD_LOGIC;
           IN0 		 : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
           IN1  		 : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
           MUX_OUT    : out  STD_LOGIC_VECTOR(31 DOWNTO 0)
			  );
end component;
   
begin

	--Generate the 5 to 32 Decoder
	dec_5to32 : DECODER_5to32
	port map(
				Awr => Awr,
				WrEn => WrEn, 
				Decoder5to32_Out => decoder_5to32_out
				);
			
	--AND all the outputs of the decoder with WrEn
	REG_GEN:
	for i in 0 to 31 generate
		WrEn_AND_decoder_5to32_out(i) <= WrEn AND decoder_5to32_out(i);
		register_instance : rgstr port map(
						RST => RST,
						CLK => CLK,
						we => WrEn_AND_decoder_5to32_out(i),								
						Dout => register_outputs(i,0),
						Data => Din
						);
	end generate;
		
	
	upper_mux32to1 : MUX_32to1
	port map(
		  IN0 => register_outputs(0,0),
        IN1 => register_outputs(1,0),
		  IN2 => register_outputs(2,0),
		  IN3 => register_outputs(3,0),
		  IN4 => register_outputs(4,0),
		  IN5 => register_outputs(5,0),
		  IN6 => register_outputs(6,0),
		  IN7 => register_outputs(7,0),
		  IN8 => register_outputs(8,0),
		  IN9 => register_outputs(9,0),
		  IN10 => register_outputs(10,0),
		  IN11 => register_outputs(11,0),
		  IN12 => register_outputs(12,0),
		  IN13 => register_outputs(13,0),
		  IN14 => register_outputs(14,0),
		  IN15 => register_outputs(15,0),
		  IN16 => register_outputs(16,0),
		  IN17 => register_outputs(17,0),
		  IN18 => register_outputs(18,0),
		  IN19 => register_outputs(19,0),
		  IN20 => register_outputs(20,0),
		  IN21 => register_outputs(21,0),
		  IN22 => register_outputs(22,0),
		  IN23 => register_outputs(23,0),
		  IN24 => register_outputs(24,0),
		  IN25 => register_outputs(25,0),
		  IN26 => register_outputs(26,0),
		  IN27 => register_outputs(27,0),
		  IN28 => register_outputs(28,0),
		  IN29 => register_outputs(29,0),
		  IN30 => register_outputs(30,0),
		  IN31 => register_outputs(31,0),
		  SEL  => Ard1,
		  MUX32to1_Out => in0_upper_mux2to1
		);	

	lower_mux32to1 : MUX_32to1
	port map(
		  IN0 => register_outputs(0,0),
        IN1 => register_outputs(1,0),
		  IN2 => register_outputs(2,0),
		  IN3 => register_outputs(3,0),
		  IN4 => register_outputs(4,0),
		  IN5 => register_outputs(5,0),
		  IN6 => register_outputs(6,0),
		  IN7 => register_outputs(7,0),
		  IN8 => register_outputs(8,0),
		  IN9 => register_outputs(9,0),
		  IN10 => register_outputs(10,0),
		  IN11 => register_outputs(11,0),
		  IN12 => register_outputs(12,0),
		  IN13 => register_outputs(13,0),
		  IN14 => register_outputs(14,0),
		  IN15 => register_outputs(15,0),
		  IN16 => register_outputs(16,0),
		  IN17 => register_outputs(17,0),
		  IN18 => register_outputs(18,0),
		  IN19 => register_outputs(19,0),
		  IN20 => register_outputs(20,0),
		  IN21 => register_outputs(21,0),
		  IN22 => register_outputs(22,0),
		  IN23 => register_outputs(23,0),
		  IN24 => register_outputs(24,0),
		  IN25 => register_outputs(25,0),
		  IN26 => register_outputs(26,0),
		  IN27 => register_outputs(27,0),
		  IN28 => register_outputs(28,0),
		  IN29 => register_outputs(29,0),
		  IN30 => register_outputs(30,0),
		  IN31 => register_outputs(31,0),
		  SEL  => Ard2,
		  MUX32to1_Out => in0_lower_mux2to1
		);	
		
		upper_mux2to1 : MUX_2to1
		port map(
			  SEL => sel_upper_mux2to1, 
           IN0 => in0_upper_mux2to1,
           IN1 => Din,
           MUX_OUT => Dout1
		);
		
		lower_mux2to1 : MUX_2to1
		port map(
			  SEL => sel_lower_mux2to1, 
           IN0 => in0_lower_mux2to1,
           IN1 => Din,
           MUX_OUT => Dout2
		);
		
		upper_cmpr_module : Compare_Module
		port map(
			Ard => Ard1,
         Awr => Awr,
			WrEn => WrEn,
			cmpr_Out => sel_upper_mux2to1
		);
		
		lower_cmpr_module : Compare_Module
		port map(
			Ard => Ard2,
         Awr => Awr,
			WrEn => WrEn,
			cmpr_Out => sel_lower_mux2to1
		);

end Behavioral;