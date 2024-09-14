from itertools import product
import argparse
import sys
import pickle
from pathlib import Path
import os
import tqdm
import glob
import pandas as pd
import re
import csv

year_pat = re.compile(r'[12]\d\d\d')

def parse_result(res):
    title = res.get('title', None)
    link = res.get('link', None)
    try:
        cited_by = int(res['inline_links']['cited_by']['total'])
    except (KeyError, TypeError):
        cited_by = None
    try:
        year = year_pat.findall(res['publication_info']['summary'])
    except KeyError:
        year = None
    if year:
        year = int(year[-1])
    else:
        year = None
    return [title, link, cited_by, year]


if __name__ == '__main__':
    parser = argparse.ArgumentParser('make_comb')
    parser.add_argument('-d', '--output-dir', default='results')

    args = parser.parse_args()
    output_dir = args.output_dir

    search_queries = glob.glob(f'{output_dir}/*.p')

    all_data = []
    for filename in tqdm.tqdm(search_queries):
        with open(filename, 'rb') as f:
            s = pickle.loads(f.read())
        ml_term, bio_term = s['search_parameters']['q'].split('" "') # split on middle quotes
        ml_term = ml_term[1:]
        bio_term = bio_term[:-1]
        results = [[ml_term, bio_term] + parse_result(res) for res in s['organic_results']]
        all_data.extend(results)

    data = pd.DataFrame(all_data, columns=['Model', 'Bio_term', 'Title', 'Link', 'Citations', 'Year'])
    data['Year'] = data['Year'].astype('Int64')
    data['Citations'] = data['Citations'].astype('Int64')
    data.to_csv(f'{output_dir}/all_results.csv', index=False, quoting=csv.QUOTE_NONNUMERIC)



