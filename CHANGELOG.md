# [Pueri](https://github.com/Nereare/pueri) Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.11.5] - `2019-11-02`

### Changed
* Update Hippocratic License to `v1.2`.
* Update `Gemspec` license to `Hippocratic`.

## [0.11.4] - `2019-10-28`

### Changed
* Included prettified output for `DoseCalc`'s `to_s` method.
* Included prettified output for `DoseCheck`'s `to_s` method.

## [0.11.2] - `2019-10-28`

### Added
* [Disclaimer](ABOUT.md), regarding the objectives and limitations of this project.
* `DoseCalc`, a class for calculating the dosage of medications for pediatric patients.
* `DoseCheck`, a class for checking the dosage-per-weight-day of prescribed medications.

### Changed
* Bumped [RuboCop](https://github.com/rubocop-hq/rubocop) to `v.0.76.0`.

## [0.7.0] - `2019-10-19`

### Added
* Code of Conduct from [Contributor Covenant v1.4.1](https://www.contributor-covenant.org/).
* [License](LICENSE.md).
* Git metafiles (`.gitignore` and `.gitattributes`).
* GitHub templates:
  - Issues;
  - Feature request;
  - User question;
  - Pull request.
* ReadMe file.
* Changelog file.
* Age calculator, with year, month, and day discrimination, and two formats (short and long).
* Vaccine Calendar checker, based on the one from [Brazil's PNI][PNI], 2019.
* Neuropsichosocial development, based on [this guide][DNPM] from Unicamp.

[PNI]: http://www.saude.gov.br/saude-de-a-z/vacinacao/calendario-vacinacao
[DNPM]: https://www.fcm.unicamp.br/fcm/neuropediatria-conteudo-didatico/desenvolvimento-neuropsicomotor

[Unreleased]: https://github.com/Nereare/pueri/compare/v0.11.5...HEAD
[0.11.5]: https://github.com/Nereare/pueri/compare/v0.11.4...v0.11.5
[0.11.4]: https://github.com/Nereare/pueri/compare/v0.11.2...v0.11.4
[0.11.2]: https://github.com/Nereare/pueri/compare/v0.7.0...v0.11.2
[0.7.0]: https://github.com/Nereare/pueri/releases/tag/v0.7.0
