from itertools import product
import argparse
import sys
import pickle
from pathlib import Path
import os
import tqdm
try:
    import serpapi
except ImportError:
    serpapi = None



if __name__ == '__main__':
    parser = argparse.ArgumentParser('make_comb')
    parser.add_argument('-m', '--ml-terms', default='ml.txt')
    parser.add_argument('-b', '--bio-terms', default='bio.txt')
    parser.add_argument('-o', '--output-dir', default='')
    parser.add_argument('-t', '--token', default='')

    args = parser.parse_args()
    ml_file = args.ml_terms
    bio_file = args.bio_terms
    output_dir = args.output_dir
    output = f'{output_dir}/queries.txt'
    token_file = args.token

    with open(ml_file,'r') as f:
        ml_terms = [l.strip() for l in f.readlines()]

    with open(bio_file,'r') as f:
        bio_terms = [l.strip() for l in f.readlines()]

    with open(token_file,'r') as f:
        token = f.read().strip()

    client = serpapi.Client(api_key=token)

    os.makedirs(output_dir)

    comb_gen = product(ml_terms, bio_terms)

    if output:
        f = open(output,'w')
    else:
        f = sys.stdout

    for query in tqdm.tqdm(comb_gen, total=len(ml_terms)*len(bio_terms)):
        search = " ".join([f'"{q}"' for q in query])
        print(search, file=f)
        if serpapi is not None:
            s = client.search(q=search, engine='google_scholar', num=100)
            simple_search = search.replace(' ', '_').replace('"', '')
            # just titles and links for simplicity
            with open(f'{output_dir}/{simple_search}.txt','w') as f2:
                for paper in s['organic_results']:
                    print(f"{paper['title']}, {paper['link']}", file=f2)
            # actual pickle files to be rebuilt
            with open(f'{output_dir}/{simple_search}.p','wb') as f2:
                f2.write(pickle.dumps(s))

    f.close()

