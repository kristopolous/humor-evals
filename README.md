# Joke Evaluation Benchmark

A simple benchmark for evaluating language models' ability to distinguish between good and bad jokes, based on Reddit voting data.

## Overview

This project tests whether language models can identify which of two jokes is funnier, using a dataset of 195,000+ Reddit jokes with community scores. Models are presented with pairs of jokes (one highly upvoted, one poorly rated) and must choose the funnier one.

## How It Works

### Core Concept
- **Dataset**: 195,000+ jokes from Reddit, sorted by score (upvotes - downvotes)
- **Test pairs**: For each trial, select:
  - One joke from the bottom `offset` positions (lowest scores)
  - One joke from the top `offset` positions (highest scores)
- **Shuffling**: Joke positions (A/B) are randomized to avoid positional bias
- **Evaluation**: Model must output "A" or "B" indicating which joke is funnier
- **Scoring**: Percentage of correct choices over 30 trials

### The Benchmark
Models are tested on their ability to:
1. Understand humor (setup + punchline structure)
2. Align with human preferences (Reddit voting patterns)
3. Follow simple instructions (output only "A" or "B")

4. **Ensure `llcat` is available**:

pipx install llcat

### Run a single test:
```bash
# Get the correct answer and prompt for offset 1
./joke_eval.py 1
```

### Prompt Format
```
Which joke is funnier? Say only "A" or "B". Do not be conversational.
<Joke A><setup>{setup}</setup>
<punchline>{punchline}</punchline></Joke A>
<Joke B><setup>{setup}</setup>
<punchline>{punchline}</punchline>
</Joke B>
```

### Response Parsing
The benchmark extracts the first "A" or "B" from the model's response, ignoring all other text and whitespace.

### Randomization
Each test uses `random.shuffle()` to randomize which joke appears as A vs B, preventing positional bias in model responses.

## License

MIT License - see LICENSE file for details.

## Acknowledgments

- Reddit joke dataset from [taivop/joke-dataset](https://github.com/taivop/joke-dataset)
- Inspired by the need for simple, interpretable LLM benchmarks
- Thanks to the Ollama team for easy local model serving
