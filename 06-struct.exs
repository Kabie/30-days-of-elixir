ExUnit.start

defmodule User do
  defstruct email: nil, password: nil

  defimpl String.Chars, for: User do
    def to_string(%User{email: email}) do
      email
    end
  end
end

defmodule StructTest do
  use ExUnit.Case

  defmodule ScopeTest do
    use ExUnit.Case

    defmodule Person do
      defstruct first_name: nil, last_name: nil, age: nil
    end

    test "defrecordp" do
      p = %Person{first_name: "Kai", last_name: "Morgan", age: 5}
      assert p == %{__struct__: Person, first_name: "Kai", last_name: "Morgan", age: 5} # just a Map!
    end
  end

  # CompileError
  # test "defrecordp out of scope" do
  #   %Person{}
  # end

  def sample do
    %User{email: "kai@example.com", password: "trains"} # %{} as named Map
  end

  test "defstruct" do
    assert sample == %{__struct__: User, email: "kai@example.com", password: "trains"}
  end

  test "property" do
    assert sample.email == "kai@example.com"
  end

  test "put" do
    u = sample
    u2 = Map.put u, :email, "tim@example.com"
    assert u2 == %{__struct__: User, email: "tim@example.com", password: "trains"}
  end

  test "protocol" do
    assert to_string(sample) == "kai@example.com"
  end
end

