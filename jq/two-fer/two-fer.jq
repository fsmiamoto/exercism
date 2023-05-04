# You might want to look at:
#
# - the alternative operator:
#   https://stedolan.github.io/jq/manual/v1.6/#Alternativeoperator://
#
# - string interpolation:
#   https://stedolan.github.io/jq/manual/v1.6/#Stringinterpolation-%5C(foo)

.name //= "you" | "One for \(.name), one for me."
