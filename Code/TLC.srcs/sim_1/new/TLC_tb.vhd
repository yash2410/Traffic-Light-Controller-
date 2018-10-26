library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity TLC_Control_tb is
end;

architecture bench of TLC_Control_tb is

  component TLC_Control
  	Port (
  		CLK, RST : In STD_LOGIC;
  	    Y, G, R : Out STD_LOGIC_VECTOR(3 Downto 0)
  	);
  end component;

  signal CLK, RST: STD_LOGIC := '0';
  signal Y, G, R: STD_LOGIC_VECTOR(3 Downto 0) ;

begin

  uut: TLC_Control port map ( CLK => CLK,
                              RST => RST,
                              Y   => Y,
                              G   => G,
                              R   => R );

  CLK: process
  begin
    CLK <= not CLK;
    wait for 10ns;
  end process;


end;