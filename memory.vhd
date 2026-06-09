library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memory is
    port (
        clock      : in  std_logic;
        reset      : in  std_logic;
        address    : in  std_logic_vector (7 downto 0);
        data_in    : in  std_logic_vector (7 downto 0);
        write      : in  std_logic;
        port_in_00 : in  std_logic_vector (7 downto 0);
        port_in_01 : in  std_logic_vector (7 downto 0);
        port_in_02 : in  std_logic_vector (7 downto 0);
        port_in_03 : in  std_logic_vector (7 downto 0);
        port_in_04 : in  std_logic_vector (7 downto 0);
        port_in_05 : in  std_logic_vector (7 downto 0);
        port_in_06 : in  std_logic_vector (7 downto 0);
        port_in_07 : in  std_logic_vector (7 downto 0);
        port_in_08 : in  std_logic_vector (7 downto 0);
        port_in_09 : in  std_logic_vector (7 downto 0);
        port_in_10 : in  std_logic_vector (7 downto 0);
        port_in_11 : in  std_logic_vector (7 downto 0);
        port_in_12 : in  std_logic_vector (7 downto 0);
        port_in_13 : in  std_logic_vector (7 downto 0);
        port_in_14 : in  std_logic_vector (7 downto 0);
        port_in_15 : in  std_logic_vector (7 downto 0);
        data_out   : out std_logic_vector (7 downto 0);
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
end entity;

architecture behavior of memory is

    -- --------------------------------------------------------
    -- CONSTANTES DE INSTRUCCIONES
    -- --------------------------------------------------------
    constant LDA_IMM : std_logic_vector (7 downto 0) := x"86";
    constant LDA_DIR : std_logic_vector (7 downto 0) := x"87";
    constant LDB_IMM : std_logic_vector (7 downto 0) := x"88";
    constant LDB_DIR : std_logic_vector (7 downto 0) := x"89";
    constant STA_DIR : std_logic_vector (7 downto 0) := x"96";
    constant STB_DIR : std_logic_vector (7 downto 0) := x"97";
    constant ADD_AB  : std_logic_vector (7 downto 0) := x"42";
    constant SUB_AB  : std_logic_vector (7 downto 0) := x"43";
    constant AND_AB  : std_logic_vector (7 downto 0) := x"44";
    constant OR_AB   : std_logic_vector (7 downto 0) := x"45";
    constant INCA    : std_logic_vector (7 downto 0) := x"46";
    constant INCB    : std_logic_vector (7 downto 0) := x"47";
    constant DECA    : std_logic_vector (7 downto 0) := x"48";
    constant DECB    : std_logic_vector (7 downto 0) := x"49";
    constant BRA     : std_logic_vector (7 downto 0) := x"20";
    constant BMI     : std_logic_vector (7 downto 0) := x"21";
    constant BPL     : std_logic_vector (7 downto 0) := x"22";
    constant BEQ     : std_logic_vector (7 downto 0) := x"23";
    constant BNE     : std_logic_vector (7 downto 0) := x"24";
    constant BVS     : std_logic_vector (7 downto 0) := x"25";
    constant BVC     : std_logic_vector (7 downto 0) := x"26";
    constant BCS     : std_logic_vector (7 downto 0) := x"27";
    constant BCC     : std_logic_vector (7 downto 0) := x"28";

    -- --------------------------------------------------------
    -- ROM - MEMORIA DE PROGRAMA (0 a 127)
    -- --------------------------------------------------------
    type rom_type is array (0 to 127) of std_logic_vector (7 downto 0);

    constant ROM : rom_type := (
        0      => LDA_IMM,
        1      => x"AA",
        2      => STA_DIR,
        3      => x"E0",
        4      => BRA,
        5      => x"00",
        others => x"00"
    );

    signal rom_data_out : std_logic_vector (7 downto 0);
    signal EN_rom       : std_logic;

    -- --------------------------------------------------------
    -- RAM - MEMORIA DE DATOS (128 a 223)
    -- --------------------------------------------------------
    type rw_type is array (128 to 223) of std_logic_vector (7 downto 0);
    signal RW : rw_type;

    signal rw_data_out : std_logic_vector (7 downto 0);
    signal EN_rw       : std_logic;

begin

    -- --------------------------------------------------------
    -- HABILITACIÓN ROM
    -- --------------------------------------------------------
    enable_rom : process (address)
    begin
        if ((to_integer(unsigned(address)) >= 0) and
            (to_integer(unsigned(address)) <= 127)) then
            EN_rom <= '1';
        else
            EN_rom <= '0';
        end if;
    end process;

    -- --------------------------------------------------------
    -- LECTURA ROM (sincrónica)
    -- --------------------------------------------------------
    memory_rom : process (clock)
    begin
        if (clock'event and clock = '1') then
            if (EN_rom = '1') then
                rom_data_out <= ROM(to_integer(unsigned(address)));
            end if;
        end if;
    end process;

    -- --------------------------------------------------------
    -- HABILITACIÓN RAM
    -- --------------------------------------------------------
    enable_rw : process (address)
    begin
        if ((to_integer(unsigned(address)) >= 128) and
            (to_integer(unsigned(address)) <= 223)) then
            EN_rw <= '1';
        else
            EN_rw <= '0';
        end if;
    end process;

    -- --------------------------------------------------------
    -- LECTURA / ESCRITURA RAM (sincrónica)
    -- --------------------------------------------------------
    memory_rw : process (clock)
    begin
        if (clock'event and clock = '1') then
            if (EN_rw = '1' and write = '1') then
                RW(to_integer(unsigned(address))) <= data_in;
            elsif (EN_rw = '1' and write = '0') then
                rw_data_out <= RW(to_integer(unsigned(address)));
            end if;
        end if;
    end process;

    -- --------------------------------------------------------
    -- PUERTOS DE SALIDA (x"E0" a x"EF")
    -- --------------------------------------------------------
    U3 : process (clock, reset)
    begin
        if (reset = '0') then
            port_out_00 <= x"00";
        elsif (clock'event and clock = '1') then
            if (address = x"E0" and write = '1') then
                port_out_00 <= data_in;
            end if;
        end if;
    end process;

    U4 : process (clock, reset)
    begin
        if (reset = '0') then
            port_out_01 <= x"00";
        elsif (clock'event and clock = '1') then
            if (address = x"E1" and write = '1') then
                port_out_01 <= data_in;
            end if;
        end if;
    end process;

    U5 : process (clock, reset)
    begin
        if (reset = '0') then
            port_out_02 <= x"00";
        elsif (clock'event and clock = '1') then
            if (address = x"E2" and write = '1') then
                port_out_02 <= data_in;
            end if;
        end if;
    end process;

    U6 : process (clock, reset)
    begin
        if (reset = '0') then
            port_out_03 <= x"00";
        elsif (clock'event and clock = '1') then
            if (address = x"E3" and write = '1') then
                port_out_03 <= data_in;
            end if;
        end if;
    end process;

    U7 : process (clock, reset)
    begin
        if (reset = '0') then
            port_out_04 <= x"00";
        elsif (clock'event and clock = '1') then
            if (address = x"E4" and write = '1') then
                port_out_04 <= data_in;
            end if;
        end if;
    end process;

    U8 : process (clock, reset)
    begin
        if (reset = '0') then
            port_out_05 <= x"00";
        elsif (clock'event and clock = '1') then
            if (address = x"E5" and write = '1') then
                port_out_05 <= data_in;
            end if;
        end if;
    end process;

    U9 : process (clock, reset)
    begin
        if (reset = '0') then
            port_out_06 <= x"00";
        elsif (clock'event and clock = '1') then
            if (address = x"E6" and write = '1') then
                port_out_06 <= data_in;
            end if;
        end if;
    end process;

    U10 : process (clock, reset)
    begin
        if (reset = '0') then
            port_out_07 <= x"00";
        elsif (clock'event and clock = '1') then
            if (address = x"E7" and write = '1') then
                port_out_07 <= data_in;
            end if;
        end if;
    end process;

    U11 : process (clock, reset)
    begin
        if (reset = '0') then
            port_out_08 <= x"00";
        elsif (clock'event and clock = '1') then
            if (address = x"E8" and write = '1') then
                port_out_08 <= data_in;
            end if;
        end if;
    end process;

    U12 : process (clock, reset)
    begin
        if (reset = '0') then
            port_out_09 <= x"00";
        elsif (clock'event and clock = '1') then
            if (address = x"E9" and write = '1') then
                port_out_09 <= data_in;
            end if;
        end if;
    end process;

    U13 : process (clock, reset)
    begin
        if (reset = '0') then
            port_out_10 <= x"00";
        elsif (clock'event and clock = '1') then
            if (address = x"EA" and write = '1') then
                port_out_10 <= data_in;
            end if;
        end if;
    end process;

    U14 : process (clock, reset)
    begin
        if (reset = '0') then
            port_out_11 <= x"00";
        elsif (clock'event and clock = '1') then
            if (address = x"EB" and write = '1') then
                port_out_11 <= data_in;
            end if;
        end if;
    end process;

    U15 : process (clock, reset)
    begin
        if (reset = '0') then
            port_out_12 <= x"00";
        elsif (clock'event and clock = '1') then
            if (address = x"EC" and write = '1') then
                port_out_12 <= data_in;
            end if;
        end if;
    end process;

    U16 : process (clock, reset)
    begin
        if (reset = '0') then
            port_out_13 <= x"00";
        elsif (clock'event and clock = '1') then
            if (address = x"ED" and write = '1') then
                port_out_13 <= data_in;
            end if;
        end if;
    end process;

    U17 : process (clock, reset)
    begin
        if (reset = '0') then
            port_out_14 <= x"00";
        elsif (clock'event and clock = '1') then
            if (address = x"EE" and write = '1') then
                port_out_14 <= data_in;
            end if;
        end if;
    end process;

    U18 : process (clock, reset)
    begin
        if (reset = '0') then
            port_out_15 <= x"00";
        elsif (clock'event and clock = '1') then
            if (address = x"EF" and write = '1') then
                port_out_15 <= data_in;
            end if;
        end if;
    end process;

    -- --------------------------------------------------------
    -- MULTIPLEXOR data_out
    -- Enruta la señal correcta al CPU según la dirección
    -- --------------------------------------------------------
    MUX1 : process (address, rom_data_out, rw_data_out,
                    port_in_00, port_in_01, port_in_02, port_in_03,
                    port_in_04, port_in_05, port_in_06, port_in_07,
                    port_in_08, port_in_09, port_in_10, port_in_11,
                    port_in_12, port_in_13, port_in_14, port_in_15)
    begin
        if ((to_integer(unsigned(address)) >= 0) and
            (to_integer(unsigned(address)) <= 127)) then
            data_out <= rom_data_out;

        elsif ((to_integer(unsigned(address)) >= 128) and
               (to_integer(unsigned(address)) <= 223)) then
            data_out <= rw_data_out;

        elsif (address = x"F0") then data_out <= port_in_00;
        elsif (address = x"F1") then data_out <= port_in_01;
        elsif (address = x"F2") then data_out <= port_in_02;
        elsif (address = x"F3") then data_out <= port_in_03;
        elsif (address = x"F4") then data_out <= port_in_04;
        elsif (address = x"F5") then data_out <= port_in_05;
        elsif (address = x"F6") then data_out <= port_in_06;
        elsif (address = x"F7") then data_out <= port_in_07;
        elsif (address = x"F8") then data_out <= port_in_08;
        elsif (address = x"F9") then data_out <= port_in_09;
        elsif (address = x"FA") then data_out <= port_in_10;
        elsif (address = x"FB") then data_out <= port_in_11;
        elsif (address = x"FC") then data_out <= port_in_12;
        elsif (address = x"FD") then data_out <= port_in_13;
        elsif (address = x"FE") then data_out <= port_in_14;
        elsif (address = x"FF") then data_out <= port_in_15;

        else data_out <= x"00";
        end if;
    end process;

end architecture;