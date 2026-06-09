library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memory_tb is
end entity;

architecture behavior of memory_tb is

    component memory
        port (
            clock       : in  std_logic;
            reset       : in  std_logic;
            address     : in  std_logic_vector (7 downto 0);
            data_in     : in  std_logic_vector (7 downto 0);
            write       : in  std_logic;
            port_in_00  : in  std_logic_vector (7 downto 0);
            port_in_01  : in  std_logic_vector (7 downto 0);
            port_in_02  : in  std_logic_vector (7 downto 0);
            port_in_03  : in  std_logic_vector (7 downto 0);
            port_in_04  : in  std_logic_vector (7 downto 0);
            port_in_05  : in  std_logic_vector (7 downto 0);
            port_in_06  : in  std_logic_vector (7 downto 0);
            port_in_07  : in  std_logic_vector (7 downto 0);
            port_in_08  : in  std_logic_vector (7 downto 0);
            port_in_09  : in  std_logic_vector (7 downto 0);
            port_in_10  : in  std_logic_vector (7 downto 0);
            port_in_11  : in  std_logic_vector (7 downto 0);
            port_in_12  : in  std_logic_vector (7 downto 0);
            port_in_13  : in  std_logic_vector (7 downto 0);
            port_in_14  : in  std_logic_vector (7 downto 0);
            port_in_15  : in  std_logic_vector (7 downto 0);
            data_out    : out std_logic_vector (7 downto 0);
            port_out_00 : out std_logic_vector (7 downto 0);
            port_out_01 : out std_logic_vector (7 downto 0);
            port_out_02 : out std_logic_vector (7 downto 0);
            port_out_03 : out std_logic_vector (7 downto 0);
            port_out_04 : out std_logic_vector (7 downto 0);
            port_out_05 : out std_logic_vector (7 downto 0);
            port_out_06 : out std_logic_vector (7 downto 0);
            port_out_07 : out std_logic_vector (7 downto 0);
            port_out_08 : out std_logic_vector (7 downto 0);
            port_out_09 : out std_logic_vector (7 downto 0);
            port_out_10 : out std_logic_vector (7 downto 0);
            port_out_11 : out std_logic_vector (7 downto 0);
            port_out_12 : out std_logic_vector (7 downto 0);
            port_out_13 : out std_logic_vector (7 downto 0);
            port_out_14 : out std_logic_vector (7 downto 0);
            port_out_15 : out std_logic_vector (7 downto 0)
        );
    end component;

    signal clock       : std_logic := '0';
    signal reset       : std_logic := '0';
    signal address     : std_logic_vector (7 downto 0) := x"00";
    signal data_in     : std_logic_vector (7 downto 0) := x"00";
    signal write       : std_logic := '0';

    signal port_in_00  : std_logic_vector (7 downto 0) := x"AA";
    signal port_in_01  : std_logic_vector (7 downto 0) := x"BB";
    signal port_in_02  : std_logic_vector (7 downto 0) := x"CC";
    signal port_in_03  : std_logic_vector (7 downto 0) := x"DD";
    signal port_in_04  : std_logic_vector (7 downto 0) := x"00";
    signal port_in_05  : std_logic_vector (7 downto 0) := x"00";
    signal port_in_06  : std_logic_vector (7 downto 0) := x"00";
    signal port_in_07  : std_logic_vector (7 downto 0) := x"00";
    signal port_in_08  : std_logic_vector (7 downto 0) := x"00";
    signal port_in_09  : std_logic_vector (7 downto 0) := x"00";
    signal port_in_10  : std_logic_vector (7 downto 0) := x"00";
    signal port_in_11  : std_logic_vector (7 downto 0) := x"00";
    signal port_in_12  : std_logic_vector (7 downto 0) := x"00";
    signal port_in_13  : std_logic_vector (7 downto 0) := x"00";
    signal port_in_14  : std_logic_vector (7 downto 0) := x"00";
    signal port_in_15  : std_logic_vector (7 downto 0) := x"00";

    signal data_out    : std_logic_vector (7 downto 0);
    signal port_out_00 : std_logic_vector (7 downto 0);
    signal port_out_01 : std_logic_vector (7 downto 0);
    signal port_out_02 : std_logic_vector (7 downto 0);
    signal port_out_03 : std_logic_vector (7 downto 0);
    signal port_out_04 : std_logic_vector (7 downto 0);
    signal port_out_05 : std_logic_vector (7 downto 0);
    signal port_out_06 : std_logic_vector (7 downto 0);
    signal port_out_07 : std_logic_vector (7 downto 0);
    signal port_out_08 : std_logic_vector (7 downto 0);
    signal port_out_09 : std_logic_vector (7 downto 0);
    signal port_out_10 : std_logic_vector (7 downto 0);
    signal port_out_11 : std_logic_vector (7 downto 0);
    signal port_out_12 : std_logic_vector (7 downto 0);
    signal port_out_13 : std_logic_vector (7 downto 0);
    signal port_out_14 : std_logic_vector (7 downto 0);
    signal port_out_15 : std_logic_vector (7 downto 0);

    constant clk_period : time := 10 ns;

begin

    UUT : memory
        port map (
            clock       => clock,       reset       => reset,
            address     => address,     data_in     => data_in,
            write       => write,
            port_in_00  => port_in_00,  port_in_01  => port_in_01,
            port_in_02  => port_in_02,  port_in_03  => port_in_03,
            port_in_04  => port_in_04,  port_in_05  => port_in_05,
            port_in_06  => port_in_06,  port_in_07  => port_in_07,
            port_in_08  => port_in_08,  port_in_09  => port_in_09,
            port_in_10  => port_in_10,  port_in_11  => port_in_11,
            port_in_12  => port_in_12,  port_in_13  => port_in_13,
            port_in_14  => port_in_14,  port_in_15  => port_in_15,
            data_out    => data_out,
            port_out_00 => port_out_00, port_out_01 => port_out_01,
            port_out_02 => port_out_02, port_out_03 => port_out_03,
            port_out_04 => port_out_04, port_out_05 => port_out_05,
            port_out_06 => port_out_06, port_out_07 => port_out_07,
            port_out_08 => port_out_08, port_out_09 => port_out_09,
            port_out_10 => port_out_10, port_out_11 => port_out_11,
            port_out_12 => port_out_12, port_out_13 => port_out_13,
            port_out_14 => port_out_14, port_out_15 => port_out_15
        );

    clk_process : process
    begin
        clock <= '0'; wait for clk_period / 2;
        clock <= '1'; wait for clk_period / 2;
    end process;

    stimulus : process
    begin
        reset <= '0'; wait for 20 ns;
        reset <= '1'; wait for 10 ns;

        write <= '0';
        address <= x"00"; wait for clk_period;
        address <= x"01"; wait for clk_period;
        address <= x"02"; wait for clk_period;
        address <= x"03"; wait for clk_period;
        address <= x"04"; wait for clk_period;
        address <= x"05"; wait for clk_period;

        address <= x"90"; data_in <= x"37"; write <= '1'; wait for clk_period;
        address <= x"91"; data_in <= x"C4"; write <= '1'; wait for clk_period;
        address <= x"92"; data_in <= x"5A"; write <= '1'; wait for clk_period;

        write <= '0';
        address <= x"90"; wait for clk_period;
        address <= x"91"; wait for clk_period;
        address <= x"92"; wait for clk_period;

        address <= x"E3"; data_in <= x"1F"; write <= '1'; wait for clk_period;
        address <= x"E4"; data_in <= x"72"; write <= '1'; wait for clk_period;
        address <= x"E5"; data_in <= x"B8"; write <= '1'; wait for clk_period;

        write <= '0';
        address <= x"F0"; wait for clk_period;
        address <= x"F1"; wait for clk_period;
        address <= x"F2"; wait for clk_period;
        address <= x"F3"; wait for clk_period;

        address <= x"EF"; data_in <= x"FF"; write <= '1'; wait for clk_period;

        wait;
    end process;

end architecture;