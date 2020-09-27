defmodule ProteinTranslation do
  @proteins %{
    "UGU" => "Cysteine",
    "UGC" => "Cysteine",
    "UUA" => "Leucine",
    "UUG" => "Leucine",
    "AUG" => "Methionine",
    "UUU" => "Phenylalanine",
    "UUC" => "Phenylalanine",
    "UCU" => "Serine",
    "UCC" => "Serine",
    "UCA" => "Serine",
    "UCG" => "Serine",
    "UGG" => "Tryptophan",
    "UAU" => "Tyrosine",
    "UAC" => "Tyrosine",
    "UAA" => "STOP",
    "UAG" => "STOP",
    "UGA" => "STOP"
  }

  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {atom, list(String.t())}
  def of_rna(rna) do
    rna
    |> split_into_codons
    |> Enum.map(&of_codon(&1))
    |> Enum.reduce_while([], &reducer(&1, &2))
    |> wrap_result
  end

  defp reducer({:ok, "STOP"}, acc), do: {:halt, acc}
  defp reducer({:ok, protein}, acc), do: {:cont, acc ++ [protein]}
  defp reducer({:error, _}, _), do: {:halt, :error}

  defp wrap_result(:error), do: {:error, "invalid RNA"}
  defp wrap_result(proteins), do: {:ok, proteins}

  defp split_into_codons(rna) do
    rna |> String.split(~r/.{3}/, include_captures: true, trim: true)
  end

  @doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """
  @spec of_codon(String.t()) :: {atom, String.t()}
  def of_codon(codon) do
    @proteins
    |> Map.fetch(codon)
    |> wrap_fetch_result
  end

  defp wrap_fetch_result(:error) do
    {:error, "invalid codon"}
  end

  defp wrap_fetch_result({:ok, _} = protein) do
    protein
  end
end
