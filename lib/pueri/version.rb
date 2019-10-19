# frozen_string_literal: true

# This module is a support for physicians and nurses who work on Primary Care
# with children age 12 and younger. It calculates the child's age and outputs
# an optimal vaccination scheme for such age, based on Brazil's National Program
# of Immunization (PNI), using the 2019 uptade.
module Pueri
  # Sets the current version of the gem
  @version = '0.4.0'

  # Returns the Gem's current version.
  #
  # @return [String] The Gem's current version.
  def self.version
    @version
  end
end
