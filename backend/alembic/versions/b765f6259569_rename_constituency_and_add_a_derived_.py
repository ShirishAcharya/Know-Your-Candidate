"""rename constituency and add a derived column

Revision ID: b765f6259569
Revises: 79ce1cdc997f
Create Date: 2025-12-01 12:19:19.670372

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = 'b765f6259569'
down_revision: Union[str, Sequence[str], None] = '79ce1cdc997f'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade():
    op.alter_column(
        'candidate',
        'constituency',
        new_column_name = 'federal_constituency'
    )

    op.add_column(
        'candidate',
        sa.Column('constituency' , sa.String(length = 50) , nullable = True)
    )

    op.execute("""
        UPDATE candidate
        SET constituency = 
               CASE 
                    WHEN election_type = 'Proportionate' THEN NULL
                    WHEN provincial_constituency IS NULL THEN federal_constituency
                    ELSE federal_constituency || '(' || provincial_constituency || ')' 
               END
               """)


def downgrade():
    op.drop_column('candidate' , 'constituency')

    op.alter_column(
        'candidate',
        'federal_constituency',
        new_column_name = 'constituency'
    )
