entity hello is
end entity hello;

architecture arc of hello is
begin
    assert false report "Hello World!" severity note;
end architecture arc;
