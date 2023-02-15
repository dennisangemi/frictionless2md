# indecis.it dataset

This dataset was created during the italian election campaign of 2022. indecis.it website fetches and display these data in order to highlight differences in electoral programs.

## Repository structure 
```
.
├── README.md
├── data
│   └── trasmissioni.csv
├── datapackage-old.yaml
├── datapackage.json
├── datapackage.yaml
├── diary.md
├── metadata.md
├── requirements.txt
├── script.sh
└── template.md
```

## Data Dictionary 
### 📄 [categories](data/categories.csv)
- Path: `data/categories.csv`
- URL:
- Delimiter:
- Encoding: `utf-8`

| Field | Type | Description |
| --- | --- | --- |
| id | integer |  |
| slug | string |  |
| name | string | Italian name of the category |
| description | string | Italian description of the category |

### 📄 [coalitions](data/coalitions.csv)
- Path: `data/coalitions.csv`
- URL:
- Delimiter:
- Encoding: `utf-8`

| Field | Type | Description |
| --- | --- | --- |
| id | integer |  |
| coalition | string |  |

### 📄 [endorsements](data/endorsements.csv)
- Path: `data/endorsements.csv`
- URL:
- Delimiter:
- Encoding: `utf-8`

| Field | Type | Description |
| --- | --- | --- |
| id | integer |  |
| description | string | Description of endorsement types |
| icon | string | Color of the icon to display |
| color_code | string | HEX code |

### 📄 [glossary](data/glossary.csv)
- Path: `data/glossary.csv`
- URL:
- Delimiter:
- Encoding: `utf-8`

| Field | Type | Description |
| --- | --- | --- |
| id | integer |  |
| subject | string |  |
| slug | string |  |
| url | string | URL of an external reference |
| source | string |  |
| title | string |  |
| description | string | Subject description |

### 📄 [items](data/items.csv)
- Path: `data/items.csv`
- URL:
- Delimiter:
- Encoding: `utf-8`

| Field | Type | Description |
| --- | --- | --- |
| id | integer |  |
| category | string | Category name in Italian |
| category_id | integer |  |
| subject | string |  |
| subject_slug | string |  |
| subject_id | integer |  |
| source | string |  |
| source_slug | string |  |
| list | string |  |
| list_id | integer |  |
| endorsement | string | Endorsement referred to the subject. See endorsements file for more information. |
| description | string | Description of the position taken by the list |

### 📄 [leaders](data/leaders.csv)
- Path: `data/leaders.csv`
- URL:
- Delimiter:
- Encoding: `utf-8`

| Field | Type | Description |
| --- | --- | --- |
| id | integer |  |
| name | string |  |
| surname | string |  |
| list | string | Electoral list name |
| list_id | integer | Electoral list ID |
| profile_pic | string | Profile image URL |
| wikipedia_url | string | Wikipedia page URL |

### 📄 [lists](data/lists.csv)
- Path: `data/lists.csv`
- URL:
- Delimiter:
- Encoding: `utf-8`

| Field | Type | Description |
| --- | --- | --- |
| id | integer | Electoral list ID |
| list | string | Electoral list name |
| slug | string | Electoral list slug |
| symbol_name | string |  |
| symbol_url | string |  |

### 📄 [parties](data/parties.csv)
- Path: `data/parties.csv`
- URL:
- Delimiter:
- Encoding: `utf-8`

| Field | Type | Description |
| --- | --- | --- |
| id | integer |  |
| party | string |  |
| list_id | integer | Electoral list ID |
| list | string | Electoral list name |
| coalition_id | integer |  |
| coalition | string |  |

### 📄 [sources](data/sources.csv)
- Path: `data/sources.csv`
- URL:
- Delimiter:
- Encoding: `utf-8`

| Field | Type | Description |
| --- | --- | --- |
| id | integer |  |
| title | string |  |
| slug | string |  |
| type | string |  |
| url | string |  |
| list | string | Electoral list name |
| list_id | integer | Electoral list ID |

### 📄 [press](data/press.csv)
- Path: `data/press.csv`
- URL:
- Delimiter:
- Encoding: `utf-8`

| Field | Type | Description |
| --- | --- | --- |
| id | integer |  |
| post_id | integer |  |
| url | string |  |
| post_title | string |  |
| post_subtitle | string |  |
| type | string |  |
| source | string |  |
| subject | string |  |
| list | string |  |
| subject_id | integer |  |
| list_id | integer |  |

### 📄 [categories-json-version](data/categories.json)
- Path: `data/categories.json`
- URL:
- Delimiter:
- Encoding: `utf-8`


### 📄 [coalitions-json-version](data/coalitions.json)
- Path: `data/coalitions.json`
- URL:
- Delimiter:
- Encoding: `utf-8`


### 📄 [endorsements-json-version](data/endorsements.json)
- Path: `data/endorsements.json`
- URL:
- Delimiter:
- Encoding: `utf-8`


### 📄 [glossary-json-version](data/glossary.json)
- Path: `data/glossary.json`
- URL:
- Delimiter:
- Encoding: `utf-8`


### 📄 [lists-json-version](data/lists.json)
- Path: `data/lists.json`
- URL:
- Delimiter:
- Encoding: `utf-8`


### 📄 [parties-json-version](data/parties.json)
- Path: `data/parties.json`
- URL:
- Delimiter:
- Encoding: `utf-8`


### 📄 [sources-json-version](data/sources.json)
- Path: `data/sources.json`
- URL:
- Delimiter:
- Encoding: `utf-8`


### 📄 [leaders-json-version](data/leaders.json)
- Path: `data/leaders.json`
- URL:
- Delimiter:
- Encoding: `utf-8`


### 📄 [items-json-version](data/items.json)
- Path: `data/items.json`
- URL:
- Delimiter:
- Encoding: `utf-8`


### 📄 [pgpolitica-json-version](data/press.json)
- Path: `data/press.json`
- URL:
- Delimiter:
- Encoding: `utf-8`



## 📖 License
Quest'opera è distribuita con Licenza [Creative Commons Attribution 4.0 ](https://creativecommons.org/licenses/by/4.0/) (CC-BY-4.0)

## 👥 Contributors
| Name | Role | Email |
| --- | --- | --- |
| Chiara Adornetto |  | chiara.adornetto.it |
| Dennis Angemi |  | dennisangemi.com |
| Carlo Canepa |  | c.canepa.it |
| Moreno Colaiacovo |  | emmecola83.com |
| Alice Nicole Ginosa |  | alicenicoleginosa.com |
| Angelo Gulina |  | gulina.angelo.com |
| Vittorio Nicoletta |  | vittorio.nicoletta.1.com |
| Lorenzo Ruffino |  | lorenzoruffino97.com |
