"""Added provincial constituency to the candidate table

Revision ID: 44fa210902ad
Revises: d56473c1b549
Create Date: 2025-11-21 15:49:25.374708

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = '44fa210902ad'
down_revision: Union[str, Sequence[str], None] = 'd56473c1b549'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    """Upgrade schema."""
    pass


def downgrade() -> None:
    """Downgrade schema."""
    pass
