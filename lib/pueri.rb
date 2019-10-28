# frozen_string_literal: true

require 'pueri/age'
require 'pueri/dosecalc'
require 'pueri/dosecheck'
require 'pueri/neuro'
require 'pueri/vax'
require 'pueri/version'

require 'pastel'
require 'tty-table'

# This module is a support for physicians and nurses who work on Primary Care
# with children age 12 and younger. It calculates the child's age and outputs
# an optimal vaccination scheme for such age, based on Brazil's National Program
# of Immunization (PNI), using the 2019 uptade.
module Pueri; end
