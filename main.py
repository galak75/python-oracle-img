import os

import oracledb


def print_db_version(db_config):
    params = oracledb.ConnectParams(host=db_config['host'], port=db_config['port'], service_name=db_config['name'])
    with oracledb.connect(user=db_config['username'], password=db_config['password'], params=params) as conn:
        print(f'Database version: {conn.version}')
        with conn.cursor() as cursor:
            cursor.execute('SELECT * FROM v$version')
            print(cursor.fetchall())
        conn.close()


if __name__ == '__main__':
    print(f'LD_LIBRARY_PATH = {os.environ["LD_LIBRARY_PATH"]}')
    print(f'{os.environ["LD_LIBRARY_PATH"]} content: \n{os.listdir(os.environ["LD_LIBRARY_PATH"])}')

    # Both calls below fail...
    # oracledb.init_oracle_client()
    oracledb.init_oracle_client(os.environ['LD_LIBRARY_PATH'])

    db_config = {
        'host': os.environ['DB_HOST'],
        'port': os.environ['DB_PORT'],
        'name': os.environ['DB_NAME'],
        'username': os.environ['DB_USERNAME'],
        'password': os.environ['DB_PASSWORD'],
    }

    print_db_version(db_config)
