# Contributing to Grain

Grain is closed-source, so there's no code in this repository to contribute
to. This guide is about filing a *good issue* instead — it helps us fix
things faster and helps you get a useful answer sooner.

## Reporting a bug

Use the [Bug report template](.github/ISSUE_TEMPLATE/01-bug-report.yml).
Before filing:

- **Search first.** Check [open](https://github.com/pattrnlabs/grain/issues?q=is%3Aissue+is%3Aopen+label%3Abug)
  and [closed](https://github.com/pattrnlabs/grain/issues?q=is%3Aissue+is%3Aclosed+label%3Abug) bug reports.
  Found yours already reported? Add a 👍 and any details that differ from
  what's already there, instead of opening a duplicate.
- **One bug per issue.** Two unrelated bugs in one issue makes both harder
  to track.
- **Include a reproduction.** "It doesn't work" is hard to act on; the
  exact query, connector, and steps that trigger it isn't.

## Suggesting a feature

Use the [Feature request template](.github/ISSUE_TEMPLATE/02-feature-request.yml)
for something Grain could do with a connector it already supports.

Wanting Grain to support a **database it doesn't support yet**? Use the
[Connector request template](.github/ISSUE_TEMPLATE/03-connector-request.yml)
instead — it asks for different information (protocol, driver, auth) and is
how we prioritize which connector to build next.

Describe the problem you're facing, not just the solution you have in mind
— it helps us find better answers than the one you started with.

## Asking a question

Check the [FAQ](README.md#faq) and the [docs](https://grain.tools/docs) first.
If your question isn't answered there, use the
[Question template](.github/ISSUE_TEMPLATE/04-question.yml).

## Account-specific issues

If your issue involves personal information — your license, your billing,
or details about your own database you don't want public — email
**support@grain.tools** instead of filing a public issue.

## Security issues

See [SECURITY.md](SECURITY.md). Please don't file these as public issues.

## Fixing an example

The `/examples` directory is the one place in this repo with actual
runnable content. Typos or broken queries there are welcome as small pull
requests.
