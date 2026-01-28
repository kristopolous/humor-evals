#!/usr/bin/env python
import json
import random
import textwrap
import sys

with open('reddit_jokes.json', 'r') as f:
    jokes = json.loads(f.read())

alljokes = list(sorted(jokes,key=lambda x: x.get('score')))
offset= int(sys.argv[1])

bad = alljokes[offset]
good = alljokes[-offset]
order = [bad,good]
random.shuffle(order)
prompt = textwrap.dedent(f"""Which joke from reddit is funnier? Reply only "A" or "B". Do not be conversational.
<Joke A><setup>{order[0]['title']}</setup>
<punchline>{order[0]['body'].strip()}</punchline></Joke A>
<Joke B><setup>{order[1]['title']}</setup>
<punchline>{order[1]['body'].strip()}</punchline></Joke B>""")

if order[0]['score'] > order[1]['score']:
    print('A')
else:
    print('B')
print(prompt)
