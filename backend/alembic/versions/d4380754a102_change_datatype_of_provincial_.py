"""change datatype of provincial_constituency from integer to string

Revision ID: d4380754a102
Revises: b765f6259569
Create Date: 2025-12-01 14:29:29.445058

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = 'd4380754a102'
down_revision: Union[str, Sequence[str], None] = 'b765f6259569'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    op.alter_column(
    'candidate',
    'provincial_constituency',
    type_=sa.String(50),
    existing_type=sa.Integer(),
    nullable=True
)

def downgrade() -> None:
    op.alter_column(
        'candidate',
        'provincial_constituency',
        type_ = sa.Integer(),
        existing_type = sa.String(length=50),
        nullable = True
    )