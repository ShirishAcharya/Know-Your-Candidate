"""add verification and timestamps to users

Revision ID: 04c825d5437f
Revises: d4380754a102
Create Date: 2025-12-12 10:35:20.621692

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa

# revision identifiers, used by Alembic.
revision: str = '04c825d5437f'
down_revision: Union[str, Sequence[str], None] = 'd4380754a102'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    op.add_column('users' , sa.Column('is_verified' , sa.Boolean() , server_default= 'false' , nullable = False))
    op.add_column('users' , sa.Column('created_at' ,sa.TIMESTAMP(timezone = True) , server_default = sa.text('now()'), nullable = False))
    op.add_column('users' , sa.Column('updated_at' , sa.TIMESTAMP(timezone= True) , server_default=sa.text('now()') , nullable = False))

    op.execute("UPDATE users SET is_verified = true WHERE password is NOT NULL") #Backfilling existing users as verified

    op.execute("""
        CREATE OR REPLACE FUNCTION trigger_set_timestamp()
        RETURNS TRIGGER AS $$
        BEGIN
            NEW.updated_at = NOW();
            RETURN NEW;
        END;
        $$ LANGUAGE plpgsql;
    """)

    op.execute("""
        CREATE TRIGGER set_timestamp
        BEFORE UPDATE ON users
        FOR EACH ROW
        EXECUTE FUNCTION trigger_set_timestamp();
    """)


def downgrade() -> None:
    op.execute("DROP TRIGGER IF EXISTS set_timestamp ON users")
    op.execute("DROP FUNCTION IF EXISTS trigger_set_timestamp()")
    op.drop_column('users', 'updated_at')
    op.drop_column('users', 'created_at')
    op.drop_column('users', 'is_verified')
