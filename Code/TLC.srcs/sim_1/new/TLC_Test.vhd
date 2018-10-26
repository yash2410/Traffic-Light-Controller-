library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity TLC_Control_tb is
end;

architecture bench of TLC_Control_tb is

  component TLC_Control
  	Port (
  		CLK, RST : In STD_LOGIC;
  		IR0,IR1,IR2,IR3 : In STD_LOGIC_VECTOR(2 downto 0);
  	    OP0,OP1,OP2,OP3 : Out STD_LOGIC_VECTOR(2 Downto 0)
  	);
  end component;

  signal CLK, RST: STD_LOGIC := '0';
  signal IR0,IR1,IR2,IR3: STD_LOGIC_VECTOR(2 downto 0) := "000";
  signal OP0,OP1,OP2,OP3: STD_LOGIC_VECTOR(2 Downto 0) ;

begin

  uut: TLC_Control port map ( CLK => CLK,
                              RST => RST,
                              IR0 => IR0,
                              IR1 => IR1,
                              IR2 => IR2,
                              IR3 => IR3,
                              OP0 => OP0,
                              OP1 => OP1,
                              OP2 => OP2,
                              OP3 => OP3 );
  stimulus: process
  begin
    IR0 <= not IR0;
    IR1 <= not IR1;
    IR2 <= not IR2;
    IR3 <= not IR3;
    wait for 200ns;
  end process;

  clocking: process
  begin
    CLK <= not CLK;
    wait for 20ns;
    
  end process;

end;